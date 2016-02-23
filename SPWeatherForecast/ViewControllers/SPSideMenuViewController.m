//
//  SPSideMenuViewController.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/27.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "SPSideMenuViewController.h"

@interface SPSideMenuViewController ()
@property (nonatomic, strong) UIViewController *mainVC;
@property (nonatomic, strong) UIViewController *backVC;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeRightGR;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeftGR;
@property (nonatomic, strong) UITapGestureRecognizer *tapGR;

@property (nonatomic, assign) BOOL isPush;
@end

@implementation SPSideMenuViewController
-(id)initWithMainViewController:(UIViewController *)mainVC andBackViewController:(UIViewController *)backVC{
    if (self = [super init]) {
        self.isPush = NO;
        _mainVC = mainVC;
        _backVC = backVC;
        self.containerView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.containerView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:self.containerView];
        [self addChildViewController:self.mainVC];
        [self.mainVC didMoveToParentViewController:self];
        self.mainVC.view.frame = self.containerView.bounds;
        [self.containerView addSubview:self.mainVC.view];
        
        
        [self addChildViewController:self.backVC];
        [self.backVC didMoveToParentViewController:self];
        self.backVC.view.frame = self.containerView.bounds;
        [self.containerView insertSubview:self.backVC.view belowSubview:self.mainVC.view];
        
        self.swipeRightGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGR:)];
        self.swipeRightGR.direction = UISwipeGestureRecognizerDirectionRight;
        [self.containerView addGestureRecognizer:self.swipeRightGR];
        self.swipeLeftGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGR:)];
        self.swipeLeftGR.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.containerView addGestureRecognizer:self.swipeLeftGR];
        self.tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
        self.tapGR.numberOfTapsRequired = 1;
        self.tapGR.numberOfTouchesRequired = 1;
        [self.mainVC.view addGestureRecognizer:self.tapGR];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad]; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)handleGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture == self.tapGR&&self.isPush == YES) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self normalStateEvent];
            self.isPush = !self.isPush;
        });
    }
}
- (void)handleSwipeGR:(UISwipeGestureRecognizer*)gesture
{
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self transformStateEvent];
            self.isPush = !self.isPush;
        });
        
        NSLog(@"right");
    }
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft&&self.isPush == YES){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self normalStateEvent];
            self.isPush = !self.isPush;
        });
        
        NSLog(@"left");
    }
}
- (void)transformStateEvent {
    
    // 初始化3D变换,获取默认值
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    
    // 透视
    perspectiveTransform.m34 = -1.0/500.0;
    
    // 位移
    perspectiveTransform = CATransform3DTranslate(perspectiveTransform, self.view.bounds.size.width/4, 0, 120);
    
    // 空间旋转
    perspectiveTransform = CATransform3DRotate(perspectiveTransform, (10) * M_PI / 180.f, 0, 1, 0);
    
    // 缩放变换
    perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.5, 0.5, 0.5);
    [UIView animateWithDuration:0.5 animations:^{
        self.mainVC.view.layer.transform = perspectiveTransform;
//        self.mainVC.view.layer.speed     = 0.5;
    }];
    
}
- (void)normalStateEvent {
    
    // 初始化3D变换,获取默认值
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    [UIView animateWithDuration:0.5 animations:^{
        self.mainVC.view.layer.transform = perspectiveTransform;
//        self.mainVC.view.layer.speed     = 0.5;
    }];
    
}

@end
