//
//  ExpandButton.m
//  Calendar
//
//  Created by Apple on 16/5/11.
//  Copyright © 2016年 yingjun. All rights reserved.
//

#import "ExpandButton.h"

static CGFloat pointSizeLen = 90.f;
@implementation ExpandButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    //这里调成了90，有点大，不过不影响
    CGFloat widthDelta = MAX(pointSizeLen - bounds.size.width, 0);
    CGFloat heightDelta = MAX(pointSizeLen - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
