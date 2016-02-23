//
//  BackViewController.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/27.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "BackViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "UserView.h"
@interface BackViewController ()

@end

@implementation BackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *blurredView = [UIImageView new];
    blurredView.frame        = CGRectMake(0, 0, Width, Height);
    [blurredView setImageToBlur:[UIImage imageNamed:@"bg"] blurRadius:15 completionBlock:nil];
    blurredView.alpha        = 0.5;
    [self.view addSubview:blurredView];
    
    
    UserView *userView = [[UserView alloc]initWithFrame:CGRectMake(0, 40, Width/2, 3*Height/4)];
    [self.view addSubview:userView];
    self.view.userInteractionEnabled = YES;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
