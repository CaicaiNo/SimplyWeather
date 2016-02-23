//
//  TestViewController.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/6.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "TestViewController.h"
#import "UpdatingView.h"
#import "WheelView.h"
@interface TestViewController ()
@property (nonatomic,strong) UpdatingView *updatingView;
@property (nonatomic,strong) WheelView *wheelView;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _updatingView = [[UpdatingView alloc]init];
    [self.view addSubview:_updatingView];
    [_updatingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.mas_equalTo(0);
    }];
    [_updatingView show];
    
//    _wheelView = [[WheelView alloc]init];
//    [self.view addSubview:_wheelView];
//    _wheelView.frame = CGRectMake(0, 100, 300, 300);
    
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
