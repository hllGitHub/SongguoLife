//
//  HLLCustomNavView.m
//  SongguoLife
//
//  Created by Apple on 16/9/1.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLCustomNavView.h"

@interface HLLCustomNavView ()

@property (nonatomic, strong)   NSString *navTitle;
@property (nonatomic, strong)   UILabel *titleLabel;

@end

@implementation HLLCustomNavView

- (instancetype)initWithTitle:(NSString *)navTitle setBackColor:(UIColor *)backColor {
    if (self = [super init]) {
        self.backgroundColor = backColor;
        _navTitle = navTitle;
        [self createLabel];
    }
    
    return self;
}

- (void)createLabel {
    self.titleLabel = [UILabel new];
    self.titleLabel.text = self.navTitle;
    self.titleLabel.font = [UIFont systemFontOfSize:18.f weight:5.f];
    [self addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(200);
        make.center.equalTo(self.center);
    }];
}

- (void)setNavAlpha:(CGFloat)navAlpha {
    _navAlpha = navAlpha;
    
}

@end
