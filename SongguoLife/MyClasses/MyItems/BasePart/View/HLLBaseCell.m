//
//  HLLBaseCell.m
//  SongguoLife
//
//  Created by Apple on 16/9/2.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLBaseCell.h"

@implementation HLLBaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    
    return self;
}

- (void)initView {
    
}

@end
