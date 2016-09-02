//
//  HLLHomeViewController.m
//  SongguoLife
//
//  Created by Apple on 16/9/1.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLHomeViewController.h"
#import "HLLCustomNavView.h"

@interface HLLHomeViewController ()

/**
 *  自定义导航栏
 */
@property (nonatomic, strong)   HLLCustomNavView *navView;

@end

@implementation HLLHomeViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 隐藏系统导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F8F1E1"];
    
    [self initData];
    [self makeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initial data and view
- (void)initData {
//    for (NSString *familyName in [UIFont familyNames]) {
//        DB_Log(@"familyName: %@", familyName);
//        if ([familyName isEqualToString:@"Candara"]) {
//            DB_Log(@"是这个");
//        }
//    }
}

- (void)makeView {
    [self makeNavView];
}

- (void)makeNavView {
    self.navView = [[HLLCustomNavView alloc]initWithTitle:@"松 果"];
    [self.view addSubview:self.navView];
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.offset(0);
        make.height.equalTo(64);
    }];
}

@end
