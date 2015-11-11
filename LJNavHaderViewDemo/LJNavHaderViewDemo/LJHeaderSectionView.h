//
//  LJHeaderView.h
//  LJNavHaderViewDemo
//
//  Created by Caolongjian on 15/11/9.
//  Copyright © 2015年 Caolongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJHeaderSectionView : UIView
//+ (id)headerViewWithTitleArray:(NSArray *)titleArray;
//@property(nonatomic, strong) NSArray *titleArray;

@property(nonatomic, copy) void(^blockIndex)(NSInteger index);



- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;


@end
