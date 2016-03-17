//
//  ViewController.m
//  OC
//
//  Created by lishuo on 16/3/17.
//  Copyright © 2016年 李硕. All rights reserved.
//

#import "ViewController.h"
#import "CycleScrollView.h"
@interface ViewController ()
@property (nonatomic, strong) CycleScrollView *cv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cv = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 20, 320, 240)];
    
    [self.view addSubview:self.cv];
    self.cv.backgroundColor = [UIColor grayColor];
    self.cv.showPageControl = true;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UIView *rview = [[UIView alloc] init];
    rview.backgroundColor = [UIColor redColor];
    
    UIView *gview = [[UIView alloc] init];
    gview.backgroundColor = [UIColor greenColor];
    
    UIView *bview = [[UIView alloc] init];
    bview.backgroundColor = [UIColor blueColor];
    
    UIView *yview = [[UIView alloc] init];
    yview.backgroundColor = [UIColor yellowColor];
    
    UIView *pview = [[UIView alloc] init];
    pview.backgroundColor = [UIColor purpleColor];
    
    self.cv.displaySource = @[rview,gview,bview,yview,pview];
    [self.cv setScrollTimeinterval:3];
}

@end
