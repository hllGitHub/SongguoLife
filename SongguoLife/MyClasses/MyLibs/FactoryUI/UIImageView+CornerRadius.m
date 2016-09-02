//
//  UIImageView+CornerRadius.m
//  MyPractise
//
//  Created by lzy on 16/3/1.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UIImageView+CornerRadius.h"
#import <objc/runtime.h>

const char kRadius;
const char kRoundingCorners;
const char kIsRounding;
const char kHadAddObserver;
const char kProcessedImage;

const char kBorderWidth;
const char kBorderColor;

//other settings
@interface UIImage (cornerRadius)

@property (nonatomic, assign)   BOOL aliCornerRadius;

@end

@implementation UIImage (cornerRadius)

- (BOOL)aliCornerRadius{
    return [objc_getAssociatedObject(self, @selector(aliCornerRadius)) boolValue];
}

- (void)setAliCornerRadius:(BOOL)aliCornerRadius{
    objc_setAssociatedObject(self, @selector(aliCornerRadius), @(aliCornerRadius), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@interface ZYImageObserver : NSObject

@property (nonatomic, assign)   UIImageView *originImageView;
@property (nonatomic, strong)   UIImage *originImage;
@property (nonatomic, assign)   CGFloat cornerRadius;

- (instancetype)initWithImageView:(UIImageView *)imageView;

@end

@implementation ZYImageObserver

- (void)dealloc{
    [self.originImageView removeObserver:self forKeyPath:@"image"];
    [self.originImageView removeObserver:self forKeyPath:@"contentMode"];
}

- (instancetype)initWithImageView:(UIImageView *)imageView{
    if (self = [super init]) {
        self.originImageView = imageView;
        [imageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        [imageView addObserver:self forKeyPath:@"contentMode" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"image"]) {
        UIImage *newImage = change[@"new"];
        if (![newImage isKindOfClass:[UIImage class]] || newImage.aliCornerRadius) {
            return;
        }
        [self updateImageView];
    }
    if ([keyPath isEqualToString:@"contentMode"]) {
        self.originImageView.image = self.originImage;
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    if (_cornerRadius == cornerRadius) {
        return;
    }
    
    _cornerRadius = cornerRadius;
    if (_cornerRadius > 0) {
        [self updateImageView];
    }
}

- (void)updateImageView{
    self.originImage = self.originImageView.image;
    if (!self.originImage) {
        return;
    }
    
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(self.originImageView.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    if (currnetContext) {
        CGContextAddPath(currnetContext, [UIBezierPath bezierPathWithRoundedRect:self.originImageView.bounds cornerRadius:self.cornerRadius].CGPath);
        CGContextClip(currnetContext);
        [self.originImageView.layer renderInContext:currnetContext];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    if ([image isKindOfClass:[UIImage class]]) {
        image.aliCornerRadius = YES;
        self.originImageView.image = image;
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateImageView];
        });
    }

}

@end

@interface UIImageView ()

@property (assign, nonatomic) CGFloat radius;
@property (assign, nonatomic) UIRectCorner roundingCorners;
@property (assign, nonatomic) CGFloat borderWidth;
@property (strong, nonatomic) UIColor *borderColor;
@property (assign, nonatomic) BOOL hadAddObserver;
@property (assign, nonatomic) BOOL isRounding;

@end

@implementation UIImageView (CornerRadius)

- (CGFloat)aliCornerRadius{
    return [self imageObserver].cornerRadius;
}

- (void)setAliCornerRadius:(CGFloat)aliCornerRadius{
    [self imageObserver].cornerRadius = aliCornerRadius;
}

- (ZYImageObserver *)imageObserver{
    ZYImageObserver *imageObserver = objc_getAssociatedObject(self, @selector(imageObserver));
    if (!imageObserver) {
        imageObserver = [[ZYImageObserver alloc]initWithImageView:self];
        objc_setAssociatedObject(self, @selector(imageObserver), imageObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return imageObserver;
}


/**
 * @brief init the Rounding UIImageView, no off-screen-rendered
 */
- (instancetype)initWithRoundingRectImageView {
    self = [super init];
    if (self) {
        [self zy_cornerRadiusRoundingRect];
    }
    return self;
}

/**
 * @brief init the UIImageView with cornerRadius, no off-screen-rendered
 */
- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType {
    self = [super init];
    if (self) {
        [self zy_cornerRadiusAdvance:cornerRadius rectCornerType:rectCornerType];
    }
    return self;
}

/**
 * @brief attach border for UIImageView with width & color
 */
- (void)zy_attachBorderWidth:(CGFloat)width color:(UIColor *)color {
    self.borderWidth = width;
    self.borderColor = color;
}

#pragma mark - Kernel
/**
 * @brief clip the cornerRadius with image, UIImageView must be setFrame before, no off-screen-rendered
 */
- (void)zy_cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType {
    CGSize size = self.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    if (nil == UIGraphicsGetCurrentContext()) {
        return;
    }
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCornerType cornerRadii:cornerRadii];
    [cornerPath addClip];
    [image drawInRect:self.bounds];
    [self drawBorder:cornerPath];
    UIImage *processedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    objc_setAssociatedObject(processedImage, &kProcessedImage, @(1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.image = processedImage;
}

/**
 * @brief clip the cornerRadius with image, draw the backgroundColor you want, UIImageView must be setFrame before, no off-screen-rendered, no Color Blended layers
 */
- (void)zy_cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType backgroundColor:(UIColor *)backgroundColor {
    CGSize size = self.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    if (nil == UIGraphicsGetCurrentContext()) {
        return;
    }
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCornerType cornerRadii:cornerRadii];
    UIBezierPath *backgroundRect = [UIBezierPath bezierPathWithRect:self.bounds];
    [backgroundColor setFill];
    [backgroundRect fill];
    [cornerPath addClip];
    [image drawInRect:self.bounds];
    [self drawBorder:cornerPath];
    UIImage *processedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    objc_setAssociatedObject(processedImage, &kProcessedImage, @(1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.image = processedImage;
}

/**
 * @brief set cornerRadius for UIImageView, no off-screen-rendered
 */
- (void)zy_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType {
    self.radius = cornerRadius;
    self.roundingCorners = rectCornerType;
    self.isRounding = NO;
    
    if (!self.hadAddObserver) {
        [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        self.hadAddObserver = YES;
    }
}

/**
 * @brief become Rounding UIImageView, no off-screen-rendered
 */
- (void)zy_cornerRadiusRoundingRect {
    self.isRounding = YES;
    
    if (!self.hadAddObserver) {
        [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        self.hadAddObserver = YES;
    }
}

#pragma mark - Private
- (void)drawBorder:(UIBezierPath *)path {
    if (0 != self.borderWidth && nil != self.borderColor) {
        [path setLineWidth:2 * self.borderWidth];
        [self.borderColor setStroke];
        [path stroke];
    }
}

- (void)dealloc {
    if (self.hadAddObserver) {
        [self removeObserver:self forKeyPath:@"image"];
    }
}

- (void)validateFrame {
    if (self.frame.size.width == 0) {
        [self.class swizzleMethod:@selector(layoutSubviews) anotherMethod:@selector(zy_LayoutSubviews)];
    }
}

+ (void)swizzleMethod:(SEL)oneSel anotherMethod:(SEL)anotherSel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oneMethod = class_getInstanceMethod(self, oneSel);
        Method anotherMethod = class_getInstanceMethod(self, anotherSel);
        
        method_exchangeImplementations(oneMethod, anotherMethod);
    });
}

- (void)zy_LayoutSubviews {
    [super layoutSubviews];
    if (self.isRounding) {
        [self zy_cornerRadiusWithImage:self.image cornerRadius:self.frame.size.width/2 rectCornerType:UIRectCornerAllCorners];
    } else if (0 != self.radius && 0 != self.roundingCorners && nil != self.image) {
        [self zy_cornerRadiusWithImage:self.image cornerRadius:self.radius rectCornerType:self.roundingCorners];
    }
}

#pragma mark - KVO for .image
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"image"]) {
        UIImage *newImage = change[NSKeyValueChangeNewKey];
        if ([newImage isMemberOfClass:[NSNull class]]) {
            return;
        } else if ([objc_getAssociatedObject(newImage, &kProcessedImage) intValue] == 1) {
            return;
        }
        [self validateFrame];
        if (self.isRounding) {
            [self zy_cornerRadiusWithImage:newImage cornerRadius:self.frame.size.width/2 rectCornerType:UIRectCornerAllCorners];
        } else if (0 != self.radius && 0 != self.roundingCorners && nil != self.image) {
            [self zy_cornerRadiusWithImage:newImage cornerRadius:self.radius rectCornerType:self.roundingCorners];
        }
    }
}

#pragma mark property
- (CGFloat)borderWidth {
    return [objc_getAssociatedObject(self, &kBorderWidth) floatValue];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    objc_setAssociatedObject(self, &kBorderWidth, @(borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)borderColor {
    return objc_getAssociatedObject(self, &kBorderColor);
}

- (void)setBorderColor:(UIColor *)borderColor {
    objc_setAssociatedObject(self, &kBorderColor, borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hadAddObserver {
    return [objc_getAssociatedObject(self, &kHadAddObserver) boolValue];
}

- (void)setHadAddObserver:(BOOL)hadAddObserver {
    objc_setAssociatedObject(self, &kHadAddObserver, @(hadAddObserver), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isRounding {
    return [objc_getAssociatedObject(self, &kIsRounding) boolValue];
}

- (void)setIsRounding:(BOOL)isRounding {
    objc_setAssociatedObject(self, &kIsRounding, @(isRounding), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIRectCorner)roundingCorners {
    return [objc_getAssociatedObject(self, &kRoundingCorners) unsignedLongValue];
}

- (void)setRoundingCorners:(UIRectCorner)roundingCorners {
    objc_setAssociatedObject(self, &kRoundingCorners, @(roundingCorners), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)radius {
    return [objc_getAssociatedObject(self, &kRadius) floatValue];
}

- (void)setRadius:(CGFloat)radius {
    objc_setAssociatedObject(self, &kRadius, @(radius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end
