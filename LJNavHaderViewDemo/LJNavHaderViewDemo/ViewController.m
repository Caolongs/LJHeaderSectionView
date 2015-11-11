//
//  ViewController.m
//  LJNavHaderViewDemo
//
//  Created by Caolongjian on 15/11/9.
//  Copyright © 2015年 Caolongjian. All rights reserved.
//

#import "ViewController.h"
#import "LJHeaderSectionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;

    NSArray *titleArray = @[@"我的",@"我的ttt",@"我的",@"我的haha",@"我的",@"我的",@"我的",@"我的ttt",@"我的",@"我的haha"];
    LJHeaderSectionView *headerView = [[LJHeaderSectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35) titleArray:titleArray];
    [self.view addSubview:headerView];
    [headerView setBlockIndex:^(NSInteger index) {
        NSLog(@"ViewController %ld",index);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
