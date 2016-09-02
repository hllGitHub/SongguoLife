//
//  UIImageView+CornerRadius.h
//  MyPractise
//
//  Created by lzy on 16/3/1.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (CornerRadius)
//根据这个设置圆角，任何时候都可以，这个方法只能设置圆角，功能稍显单一
@property (nonatomic, assign) CGFloat aliCornerRadius;

//下面的这些方法必须先设置，才可以设置图片，这样圆角才会有效，功能比较强大
//此部分我会再优化
- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (void)zy_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (instancetype)initWithRoundingRectImageView;

- (void)zy_cornerRadiusRoundingRect;

- (void)zy_attachBorderWidth:(CGFloat)width color:(UIColor *)color;

- (void)zy_cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

@end
