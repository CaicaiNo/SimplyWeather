//
//  MainViewController.m
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "MainViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "FontInfomation.h"
#import "SPJuheManager.h"
#import "SPDataManager.h"
#import "DisplayView.h"
#import "HeaderView.h"
#import <Masonry.h>
#import "DisplayView.h"
#import "GCD.h"
#import "UpdatingView.h"
#import "SPDisplayData.h"
#import "FutureViewController.h"


@interface MainViewController ()<CLLocationManagerDelegate,DisplayViewDelegate>
/**
 *  定位
 */
@property (nonatomic,strong) CLLocationManager *CLManager;
/**
 *  model部分
 */
@property (nonatomic,strong) SPCurrentWeather *currentWeather;
@property (nonatomic,strong) SPTodayWeather *todayWeather;
@property (nonatomic,strong) NSArray *futureDayArray;
@property (nonatomic,strong) NSArray *futurehourArray;
@property (nonatomic,strong) SPDisplayData *displayData;


/**
 *  展示视图
 */
@property (nonatomic,strong) DisplayView *displayView;
/**
 *  头部视图
 */
@property (nonatomic,strong) HeaderView *headerView;
/**
 *  更新视图
 */
@property (nonatomic,strong) UpdatingView *updatingView;

@property (nonatomic,strong) CLLocation *lastLocation;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self firstSendRequestByCurrentLocation];
  
    //建立背景图
    UIImageView *backgroundImageView = [[UIImageView alloc]init];
    backgroundImageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    backgroundImageView.image = [UIImage imageNamed:@"iPhone 6 Plus"];
    [self.view addSubview:backgroundImageView];
    //建立头试图
    self.headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 80)];
    self.headerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.headerView];
//    [GCDQueue executeInMainQueue:^{
//        [self.headerView show];
//    }];
    //建立展示试图
    self.displayView = [[DisplayView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100)];
    self.displayView.backgroundColor = [UIColor clearColor];
    self.displayView.delegate = self;
    [self.view addSubview:self.displayView];
    //建立更新试图
    _updatingView = [[UpdatingView alloc]init];
    [self.view addSubview:_updatingView];
    [_updatingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.mas_equalTo(0);
    }];
    if (self.displayData == nil) {
        [_updatingView show];
    }
    
    
    
}

#pragma mark - location and CLLocationManagerDelegate
-(void)firstSendRequestByCurrentLocation{
    self.CLManager = [[CLLocationManager alloc]init];
    self.CLManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.CLManager.distanceFilter = 10;
    self.CLManager.delegate = self;
    if ([[UIDevice currentDevice].systemVersion doubleValue] > 8.0) {
        [self.CLManager requestWhenInUseAuthorization];
    }else{
        [self.CLManager startUpdatingLocation];
    }
}
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusDenied:
            NSLog(@"用户禁止定位");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            self.CLManager.desiredAccuracy = kCLLocationAccuracyBest;
            self.CLManager.distanceFilter = 100;
            NSLog(@"已经设置同意定位");
            [self.CLManager startUpdatingLocation];
            break;
        default:
            break;
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    self.lastLocation = [locations lastObject];
    NSLog(@"定位成功，坐标（%f，%f）,开始获取网络数据",self.lastLocation.coordinate.latitude,self.lastLocation.coordinate.longitude);
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(delayRunEvent)
               withObject:nil
               afterDelay:0.3f];
    
    [self.CLManager stopUpdatingLocation];
    self.CLManager = nil;
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [TSMessage showNotificationWithTitle:@"定位错误" subtitle:@"无法获取地理位置信息" type:TSMessageNotificationTypeWarning];
    NSLog(@"无法定位");
}
-(void)delayRunEvent
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSDictionary *dicOne = [SPJuheManager getRequestWithLocation:self.lastLocation];
        NSLog(@"dic:%@",dicOne);
        [self getDataFromDictionary:dicOne];
//        if (dicOne != nil) {
//            [self getDataFromDictionary:dicOne];
//            [TSMessage showNotificationWithTitle:@"更新成功" type:TSMessageNotificationTypeSuccess];
//        }else{
//            [TSMessage showNotificationWithTitle:@"无法获取网络数据" subtitle:@"请检查网络状况" type:TSMessageNotificationTypeWarning];
//        }
        
        
        
//        NSLog(@"test:%@,%@,%@",self.displayView.data.weatherID,self.displayView.data.maxTemp,self.displayView.data.minTemp);
    }) ;
  
   dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       [self.updatingView hide];
       [self.headerView show];
       [self.displayView show];
   });
}
-(void)getDataFromDictionary:(NSDictionary *)dic
{
    self.displayData = [SPDataManager getDisplayDataFromDictionary:dic];
    self.displayView.todayWeather = [SPDataManager parseTodayWeatherByDictionary:dic];
    self.headerView.data = [SPDataManager getHeaderDataFromDictionary:dic];
    self.displayView.data = self.displayData;
    self.futureDayArray = [SPDataManager parseFutureWeatherByDictionary:dic];
    NSDictionary *dicTwo = [SPJuheManager getThreeHoursForecastWithCityName:self.headerView.data.cityName];
    self.futurehourArray = [SPDataManager parseThreeHourWeatherForecastByDictionary:dicTwo];
}
-(void)pullUpEventWithData
{
    NSLog(@"pullup");
    FutureViewController *pushVC = [[FutureViewController alloc]init];
    pushVC.futureDayArray = self.futureDayArray;
    pushVC.futureHourArray = self.futurehourArray;
//    pushVC.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:pushVC animated:YES completion:nil];
}
-(void)pullDownToRefreshData
{
    NSLog(@"pulldown");
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        [self.updatingView show];
        [self.displayView hide];
        [self.headerView hide];
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        
        NSDictionary *dic = [SPJuheManager getRequestWithCityName:self.headerView.cityNameLabel.text];
        //        NSLog(@"dic:%@",dic);
        [self getDataFromDictionary:dic];
    }) ;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            [self.updatingView hide];
            [self.displayView show];
            [self.headerView show];
        }) ;
    });
    

    
    
}


@end
