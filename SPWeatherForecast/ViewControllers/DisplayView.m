//
//  DisplayView.m
//  SPWeatherForecast
//
//  Created by sheng on 15/12/29.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "DisplayView.h"
#import "WinnowerView.h"
#import "WeatherView.h"
#import <Masonry.h>
#import "HumidityView.h"
#import "TempView.h"
#import "HLTempView.h"
#import "GCD.h"
#import "ShapeWordView.h"
#import "TipsView.h"
#import "DragPushView.h"
@interface DisplayView ()<UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) WinnowerView *winnowerView;
@property (nonatomic,strong) WeatherView *weatherView;
@property (nonatomic,strong) HumidityView *humidityView;
@property (nonatomic,strong) TempView *tempView;
@property (nonatomic,strong) HLTempView *highLowTempView;
@property (nonatomic,strong) TipsView *tipsView;

@property (nonatomic,strong) ShapeWordView *shapeWordView;
@property (nonatomic,strong) DragPushView *dragView;
@end
@implementation DisplayView

//+(instancetype)DisplayView
//{
//    return  [[[NSBundle mainBundle] loadNibNamed:@"DisplayView" owner:nil options:nil] firstObject];
//}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
    // 加载用tableView
    self.tableView                 = [[UITableView alloc] initWithFrame:self.bounds
                                                      style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate        = self;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];

    self.weatherView               = [[WeatherView alloc]init];
    [self.tableView addSubview:self.weatherView];
    [self.weatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-(Height-100)/3);
        make.centerX.mas_equalTo(-Width/4);

    }];


    self.humidityView              = [[HumidityView alloc]init];
    [self.tableView addSubview:self.humidityView];
    [self.humidityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.centerX.mas_equalTo(-Width/4);

    }];

    self.winnowerView              = [[WinnowerView alloc]init];
    [self.tableView addSubview:self.winnowerView];
    [self.winnowerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo((Height-100)/3);
        make.centerX.mas_equalTo(-Width/4);

    }];


    self.tempView                  = [[TempView alloc]init];
    [self.tableView addSubview:self.tempView];
    [self.tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-(Height-100)/3);
        make.centerX.mas_equalTo(Width/4);
    }];


    self.highLowTempView           = [[HLTempView alloc]init];
    [self.tableView addSubview:self.highLowTempView];
    [self.highLowTempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.centerX.mas_equalTo(Width/4);
    }];
        
    self.tipsView                  = [[TipsView alloc]init];
        [self.tableView addSubview:self.tipsView];
        [self.tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo((Height-100)/3);
            make.centerX.mas_equalTo(Width/4);
        }];
        
    
//    [NSTimer scheduledTimerWithTimeInterval:9 target:self selector:@selector(hide) userInfo:nil repeats:NO];

    self.shapeWordView           = [[ShapeWordView alloc] initWithFrame:CGRectMake(0, -60, Width, 60)];
    self.shapeWordView.text      = @"Release To Reflesh";
    self.shapeWordView.font      = [UIFont fontWithName:LATO_THIN size:15];
    self.shapeWordView.lineWidth = 0.5f;
    self.shapeWordView.lineColor = [UIColor whiteColor];
    [self.shapeWordView buildView];
    [self.tableView addSubview:self.shapeWordView];
        
    self.dragView = [[DragPushView alloc]initWithFrame:CGRectMake(0,frame.size.height, Width, 30)];
//        self.dragView.backgroundColor = [UIColor redColor];
        [self.dragView buildView];
    [self.tableView addSubview:self.dragView];
    [self show];
        
  }
    return self;
}
-(void)hide
{
    [GCDQueue executeInMainQueue:^{
        [self.winnowerView hide];
        [self.weatherView hide];
        [self.humidityView hide];
        [self.tempView hide];
        [self.highLowTempView hide];
        [self.tipsView hide];
    }];
    
    
}
-(void)show
{
    if (self.data == nil) {
        return;
    }
    self.winnowerView.windDirectionStr = self.data.windDirectionStr;
    self.winnowerView.windSpeedStr = self.data.windSpeedStr;
    self.weatherView.weatherID = self.data.weatherID;
    self.humidityView.humidity = self.data.humidity;
    self.tempView.temperture = self.data.temperture;
    self.highLowTempView.maxTemp = self.data.maxTemp;
    self.highLowTempView.minTemp = self.data.minTemp;
    self.tipsView.tipsData = self.todayWeather;
//    NSLog(@"test2:%@",self.weatherView.weatherID);
   
        [self.tipsView show];
        [self.winnowerView show];
        [self.weatherView show];
        [self.humidityView show];
        [self.tempView show];
        [self.highLowTempView show];
        
   
    
}
-(void)startAnimation
{
 
        [self.winnowerView startAnimation];
        [self.weatherView startAnimation];
        [self.humidityView startAnimation];
        [self.tempView startAnimation];
        [self.highLowTempView startAnimation];
    
   
    
}
-(void)stopAnimation
{
   
        [self.winnowerView stopAnimation];
        [self.weatherView stopAnimation];
        [self.humidityView stopAnimation];
        [self.tempView stopAnimation];
        [self.highLowTempView stopAnimation];
    

    
}
#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat percent = (scrollView.contentOffset.y) / 60.f;
   
    
    if (scrollView.contentOffset.y == 0||scrollView.contentOffset.y < 0) {
        [self.dragView hide];
    }else{
        [self.dragView show];
    }
    CGFloat offsetY = -scrollView.contentOffset.y;
    
    if (offsetY >= 0.f) {
        
        percent = offsetY / 60.f;
        [self.shapeWordView percent:percent animated:NO];
    }
    NSLog(@"%f",scrollView.contentOffset.y);
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 位移超过60后执行动画效果
    if (scrollView.contentOffset.y >= 60.f) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(pullUpEventWithData)] ) {
            
            [_delegate pullUpEventWithData];
            [self.dragView hide];
            NSLog(@"推出界面");
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            
            [GCDQueue executeInMainQueue:^{
                
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                
                
            } afterDelaySecs:1.1];
        }
    }
    
    if (scrollView.contentOffset.y <= -60.f) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(pullDownToRefreshData)]) {
            
            [_delegate pullDownToRefreshData];
        }
    }
}

@end
