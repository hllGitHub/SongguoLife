//
//  HLLCustomNavView.h
//  SongguoLife
//
//  Created by Apple on 16/9/1.
//  Copyright © 2016年 HLL. All rights reserved.
//

/**
 *  自定义导航栏
 */

#import <UIKit/UIKit.h>
@class ExpandButton;

@interface HLLCustomNavView : UIView

/**
 *  导航栏透明度
 */
@property (nonatomic, assign)   CGFloat navAlpha;

/**
 *  导航栏标题
 */
@property (nonatomic, copy)   NSString *navTitle;

/**
 *  标题颜色
 */
@property (nonatomic, strong)   UIColor *titleColor;

/**
 *  导航栏背景色
 */
@property (nonatomic, strong)   UIColor *backColor;

/**
 *  是否隐藏返回按钮，默认不隐藏
 */
@property (nonatomic, assign)   BOOL    hiddenBackButton;

/**
 *  返回按钮
 */
@property (nonatomic, strong)   ExpandButton *backButton;

/**
 *  初始化
 *
 *  @param navTitle 导航栏标题
 *
 *  @return self
 */
- (instancetype)initWithTitle:(NSString *)navTitle;

/**
 *  初始化
 *
 *  @param navTitle   导航栏标题
 *  @param titleColor 标题颜色
 *
 *  @return self
 */
- (instancetype)initWithTitle:(NSString *)navTitle
                setTitleColor:(UIColor *)titleColor;

/**
 *  初始化
 *
 *  @param navTitle  导航栏标题
 *  @param backColor 导航栏背景色
 *
 *  @return self
 */
- (instancetype)initWithTitle:(NSString *)navTitle
                 setBackColor:(UIColor *)backColor;

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
                 setBackColor:(UIColor *)backColor;

/**
 *  添加左边的按钮
 *
 *  @param leftButton 左按钮
 */
- (void)addLeftButton:(UIButton *)leftButton;

/**
 *  添加多左按钮
 *
 *  @param leftButtons 左按钮列表
 */
- (void)addLeftButtons:(NSArray<UIButton *> *)leftButtons;

/**
 *  添加右边的按钮
 *
 *  @param rightButton 右按钮
 */
- (void)addRightButton:(UIButton *)rightButton;

/**
 *  添加多右按钮
 *
 *  @param rightButtons 右按钮列表
 */
- (void)setRightButtons:(NSArray<UIButton *> *)rightButtons;

@end
