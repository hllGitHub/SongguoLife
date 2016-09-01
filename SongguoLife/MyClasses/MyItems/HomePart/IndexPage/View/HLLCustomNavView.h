//
//  HLLCustomNavView.h
//  SongguoLife
//
//  Created by Apple on 16/9/1.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLLCustomNavView : UIView

@property (nonatomic, assign)   CGFloat navAlpha;

- (instancetype)initWithTitle:(NSString *)navTitle
                 setBackColor:(UIColor *)backColor;

@end
