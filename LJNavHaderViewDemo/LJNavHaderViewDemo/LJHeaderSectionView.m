//
//  LJHeaderView.m
//  LJNavHaderViewDemo
//
//  Created by Caolongjian on 15/11/9.
//  Copyright © 2015年 Caolongjian. All rights reserved.
//

#import "LJHeaderSectionView.h"

#define screenSize [UIScreen mainScreen].bounds.size
#define viewHeight 35
#define IndicatorHeight 2.
#define FontSize 15
#define LeftSpace 20
#define RightBtnSpace 30

@interface LJHeaderSectionView ()
@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic, strong) NSMutableArray * buttonArray;
@property(nonatomic, strong) NSMutableArray * indicatorArray;

@property(nonatomic, weak) UIScrollView *scrollView;
@property(nonatomic, weak) UIView *leftView;
@property(nonatomic, weak) UIView * indicatorView;

@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, weak) UIButton * selectedButton;
@property(nonatomic, weak) UIView * selectedIndicator;
@end

@implementation LJHeaderSectionView


- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray
{
    if (self = [super initWithFrame:frame]){
        _selectedIndex = NSNotFound;
        self.titleArray = titleArray;
        [self layoutUI];
        self.backgroundColor = [UIColor grayColor];
        
    }
    return self;
}

- (void)awakeFromNib
{

}
//- (void)setTitleArray:(NSArray *)titleArray
//{
//    _selectedIndex = NSNotFound;
//    self.titleArray = titleArray;
//    [self layoutUI];
//    self.backgroundColor = [UIColor grayColor];
//}

- (void)layoutUI
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(LeftSpace, 0, screenSize.width-LeftSpace-RightBtnSpace, viewHeight)];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.scrollView  =scrollView;
    
    //右
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(screenSize.width-RightBtnSpace, 0, RightBtnSpace, viewHeight-IndicatorHeight);
    [self addSubview:button];
    [button setBackgroundColor:[UIColor redColor]];
    
    //左空白
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LeftSpace, viewHeight)];
    [scrollView addSubview:leftView];
    self.leftView = leftView;

    
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    _buttonArray = [NSMutableArray array];
    _indicatorArray = [NSMutableArray array];
    
    CGFloat y = 0;
    CGFloat h = viewHeight-IndicatorHeight;
    for (int i = 0; i < self.titleArray.count; i ++) {
        NSString *title = self.titleArray[i];
        CGFloat x = [self getX];
        CGFloat w = [self getWidthByString:title];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x, y, w, h);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:FontSize];
        
        [scrollView addSubview:button];
        [_buttonArray addObject:button];
        [button addTarget:self action:@selector(sectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(x, h, w, IndicatorHeight)];
        indicatorView.backgroundColor = [UIColor redColor];
        indicatorView.hidden = YES;
        [scrollView addSubview:indicatorView];
        [_indicatorArray addObject:indicatorView];
        //indicatorView.backgroundColor = [UIColor redColor];
        if (i == 0) {
            self.indicatorView.frame = indicatorView.frame;
            self.selectedIndicator = indicatorView;
            indicatorView.hidden = NO;
            button.selected = YES;
            self.selectedButton = button;
        }
        
    }

    self.scrollView.contentSize = CGSizeMake([self getX], viewHeight);
}

- (CGFloat)getWidthByString:(NSString *)title
{
    CGRect textRect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, viewHeight-IndicatorHeight)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FontSize+2]}
                                         context:nil];
    return textRect.size.width;
}

- (CGFloat)getX
{
    CGFloat width = 0;
    for (UIButton *button in self.buttonArray) {
        width += button.frame.size.width;
    }
    return width;
}


- (void)sectionButtonClick:(UIButton *)button
{
    
    NSUInteger newIndex = [self.buttonArray indexOfObject:button];
//    NSLog(@"%ld",newIndex);
    if (newIndex == self.selectedIndex) {
        return;
    }
    self.selectedButton.selected = NO;
    self.selectedButton = button;
    self.selectedButton.selected = YES;
    self.selectedIndex = newIndex;
    [self setSelectedIndexAnimated:newIndex];
}
- (void)setSelectedIndexAnimated:(NSUInteger)selectedIndex
{
    self.indicatorView.hidden = NO;
    self.selectedIndicator.hidden = YES;
    UIView *tempIndicatorView = self.indicatorArray[selectedIndex];
    tempIndicatorView.hidden = YES;
    self.selectedIndicator = tempIndicatorView;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.frame = tempIndicatorView.frame;
    } completion:^(BOOL finished) {
        self.indicatorView.hidden = YES;
        tempIndicatorView.hidden = NO;
        
        [self.scrollView scrollRectToVisible:self.selectedIndicator.frame animated:YES];
    }];
    
    if (self.blockIndex) {
        self.blockIndex(selectedIndex);
    }
}
//- (void)willMoveToSuperview:(UIView *)newSuperview
//{
//    self.frame = CGRectMake(0, 64, screenSize.width, 35);
//}

@end
