//
//  CycleScrollView.h
//  Demo
//
//  Created by lishuo on 16/3/17.
//  Copyright © 2016年 laifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleScrollView : UIScrollView <UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *displaySource;

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) BOOL showPageControl;

@property (nonatomic, assign) void(^didTouchDisplayScrollViewOnIndex)(NSInteger index);

@property (nonatomic, assign) NSTimeInterval scrollTimeinterval;


@end
