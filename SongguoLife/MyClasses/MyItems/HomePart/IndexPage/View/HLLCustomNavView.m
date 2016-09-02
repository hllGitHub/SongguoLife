//
//  HLLCustomNavView.m
//  SongguoLife
//
//  Created by Apple on 16/9/1.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLCustomNavView.h"
#import "ExpandButton.h"

@interface HLLCustomNavView ()

@property (nonatomic, strong)   UILabel *titleLabel;

@end

@implementation HLLCustomNavView

/**
 *  初始化
 *
 *  @param navTitle 导航栏标题
 *
 *  @return self
 */
- (instancetype)initWithTitle:(NSString *)navTitle {
    return [self initWithTitle:navTitle setTitleColor:NAV_TITLE_COLOR setBackColor:NAV_BACK];
}

/**
 *  初始化
 *
 *  @param navTitle   导航栏标题
 *  @param titleColor 标题颜色
 *
 *  @return self
 */
- (instancetype)initWithTitle:(NSString *)navTitle
                setTitleColor:(UIColor *)titleColor {
    return [self initWithTitle:navTitle setTitleColor:titleColor setBackColor:NAV_BACK];
}

/**
 *  初始化
 *
 *  @param navTitle  导航栏标题
 *  @param backColor 导航栏背景色
 *
 *  @return self
 */
- (instancetype)initWithTitle:(NSString *)navTitle
                 setBackColor:(UIColor *)backColor {
    return [self initWithTitle:navTitle setTitleColor:NAV_TITLE_COLOR setBackColor:backColor];
}

/**
 *  初始化
 *
 *  @param navTitle   导航栏标题
 *  @param titleColor 标题颜色
 *  @param backColor  导航栏背景色
 *
 *  @return self
 */
- (instancetype)initWithTitle:(NSString *)navTitle
                setTitleColor:(UIColor *)titleColor
                 setBackColor:(UIColor *)backColor {
    self = [super init];
    if (self) {
        _navTitle = navTitle;
        _titleColor = titleColor;
        _backColor = NAV_BACK;
        _hiddenBackButton = NO;
        
        self.backgroundColor = _backColor;
        
        [self createLabel];
    }
    
    return self;
}

- (void)createLabel {
    self.titleLabel = [UILabel new];
    self.titleLabel.text = self.navTitle;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = _titleColor;
    self.titleLabel.font = [UIFont fontWithName:FontName size:18.f];
    [self addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(80);
        make.right.equalTo(-80);
        make.top.offset(32);
        make.height.equalTo(20);
    }];
}

- (void)addBackButton {
    ExpandButton *backButton = [ExpandButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"nav_back_touchdown"] forState:UIControlStateHighlighted];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    
}

- (void)backForward {
    
}

- (void)setNavAlpha:(CGFloat)navAlpha {
    _navAlpha = navAlpha;
    self.alpha = navAlpha;
    self.titleLabel.alpha = navAlpha;
}

- (void)addLeftButton:(UIBarButtonItem *)leftButton {
    
}

@end
