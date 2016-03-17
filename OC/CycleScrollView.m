//
//  CycleScrollView.m
//  Demo
//
//  Created by lishuo on 16/3/17.
//  Copyright © 2016年 laifeng. All rights reserved.
//

#import "CycleScrollView.h"

@interface CycleScrollView ()

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, assign) NSInteger currentPageNum;

@property (nonatomic, assign, readonly) CGFloat selfWidth;
@property (nonatomic, assign, readonly) CGFloat selfHeight;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation CycleScrollView
#pragma mark - Getter Setter Method
- (CGFloat)selfWidth {
    return CGRectGetWidth(self.frame);
}

- (CGFloat)selfHeight {
    return CGRectGetHeight(self.frame);
}

- (void)setDisplaySource:(NSArray *)displaySource{
    if (_displaySource != displaySource) {
        _displaySource = displaySource;
        for (UIView *view in displaySource) {
            view.frame = CGRectMake(0, 0, self.selfWidth, self.selfHeight);
        }
        [self setCurrentPage:self.currentPageNum];
        [self layoutSubContentViews];
        self.contentSize = CGSizeMake(self.selfWidth * 3, self.selfHeight);
        self.pageControl.numberOfPages = displaySource.count;
    }
}

- (void)setShowPageControl:(BOOL)showPageControl {
    if (_showPageControl != showPageControl) {
        _showPageControl = showPageControl;
        if (self.pageControl.superview == nil) {
            if (self.superview) {
                [self.superview addSubview:self.pageControl];
            }
        }
        if ( showPageControl == true) {
            self.pageControl.hidden = false;
        } else {
            self.pageControl.hidden = true;
        }
    }
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.enabled = false;
        _pageControl.frame = CGRectMake(100, 200, self.selfWidth - 30, 10);
        _pageControl.numberOfPages = self.displaySource.count;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (void)setScrollTimeinterval:(NSTimeInterval)scrollTimeinterval {
    if (_scrollTimeinterval != scrollTimeinterval) {
        _scrollTimeinterval = scrollTimeinterval;
        if (self.timer == nil) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:scrollTimeinterval target:self selector:@selector(autoScroll) userInfo:nil repeats:true];
        }
        if (scrollTimeinterval > 0) {
            if (self.timer) {
                [self.timer fire];
            }
        } else {
            if (self.timer) {
                [self.timer invalidate];
                self.timer = nil;
            }
        }
    }
}

- (void)renewContentOffSet {
    NSUInteger arrCount = self.displaySource.count;
    if (self.contentOffset.x == self.selfWidth * 2) {
        self.currentPageNum = (self.currentPageNum + 1 + arrCount)%arrCount;
    } else if (self.contentOffset.x == 0) {
        self.currentPageNum = (self.currentPageNum - 1 + arrCount)%arrCount;
    } else {
        return;
    }
    [self setCurrentPage:self.currentPageNum];
    self.pageControl.currentPage = self.currentPageNum;
    self.contentOffset = CGPointMake(self.selfWidth, 0);
}

- (void)setCurrentPage:(NSInteger)pageNum {
    NSUInteger arrCount = self.displaySource.count;
    [self.leftView addSubview:self.displaySource[(pageNum - 1 + arrCount)%arrCount]];
    [self.centerView addSubview:self.displaySource[pageNum]];
    [self.rightView addSubview:self.displaySource[(pageNum + 1 + arrCount)%arrCount]];
}

#pragma mark - init Method
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.pagingEnabled = true;
        self.showsHorizontalScrollIndicator = false;
        self.showsVerticalScrollIndicator = false;
        self.currentPageNum = 0;
        [self initSubContentViews];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (void)initSubContentViews {
    self.leftView = [[UIView alloc] init];
    self.centerView = [[UIView alloc] init];
    self.rightView = [[UIView alloc] init];
    [self addSubview:self.leftView];
    [self addSubview:self.centerView];
    [self addSubview:self.rightView];
}

- (void)layoutSubContentViews {
    self.leftView.frame = CGRectMake(0, 0, self.selfWidth, self.selfHeight);
    self.centerView.frame = CGRectMake(self.selfWidth, 0, self.selfWidth, self.selfHeight);
    self.rightView.frame = CGRectMake(self.selfWidth * 2, 0, self.selfWidth, self.selfHeight);
}

#pragma mark - event Method

- (void)autoScroll {
    [self setContentOffset:CGPointMake(self.selfWidth * 2, 0) animated:true];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.didTouchDisplayScrollViewOnIndex) {
        self.didTouchDisplayScrollViewOnIndex(self.currentPageNum);
    }
}

#pragma mark - Delegate Method

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self renewContentOffSet];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self renewContentOffSet];
}


@end
