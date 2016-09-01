//
//  UIColor+ZYLHexColor.h
//  Smart
//
//  Created by iThink on 11/27/15.
//  Copyright © 2015 iThink. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义颜色
#define K_COLOR_RGB(RED, GREEN, BLUE, ALPHA)	[UIColor colorWithRed:RED/255.0 green:GREEN/255.0 blue:BLUE/255.0 alpha:ALPHA]

@interface UIColor (ZYLHexColor)

/// Create hexadecimal color：hexValue & alpha
+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

/// Create hexadecimal color：hexValue
+ (UIColor*)colorWithHex:(NSInteger)hexValue;

/// Create hexadecimal code：color
+ (NSString *)hexFromUIColor: (UIColor*) color;

/**
 *  创建十六进制颜色
 *
 *  @param colorStr 十六进制颜色字符串 -- #ffffff
 *  @param alpha    透明度 -- 0~1
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)colorStr Alpha:(CGFloat)alpha;

/**
 *  创建十六进制颜色(透明度为1)
 *
 *  @param colorStr 十六进制颜色字符串 -- #ffffff
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)colorStr;



@end
