//
//  FutureViewController.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/8.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "FutureViewController.h"
#import "SPTableViewCell.h"
@interface FutureViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UITableView *futureDayTableView;
@property (nonatomic,strong) UITableView *futureHourTableView;
@end

@implementation FutureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, Width, Height);
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, StatusBarHeight, Width, Height - StatusBarHeight )];
    self.mainScrollView.contentSize = CGSizeMake(Width*2, Height - StatusBarHeight);
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    
    self.mainScrollView.pagingEnabled = YES;
    
    [self.view addSubview:self.mainScrollView];
    
    self.futureDayTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height - StatusBarHeight)];
    self.futureDayTableView.dataSource = self;
    self.futureDayTableView.delegate = self;
    [self.mainScrollView addSubview:self.futureDayTableView];
    self.futureHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(Width, 0, Width, Height - StatusBarHeight)];
    self.futureHourTableView.dataSource = self;
    self.futureHourTableView.delegate = self;
    [self.mainScrollView addSubview:self.futureHourTableView];
    
    [self.futureHourTableView registerNib:[UINib nibWithNibName:@"SPTableViewCell" bundle:nil] forCellReuseIdentifier:@"HourCell"];
    [self.futureDayTableView registerNib:[UINib nibWithNibName:@"SPTableViewCell" bundle:nil] forCellReuseIdentifier:@"FutureCell"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.mainScrollView.backgroundColor = [UIColor whiteColor];
    self.futureDayTableView.backgroundColor = [UIColor clearColor];
    self.futureHourTableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.futureHourTableView) {
        return self.futureHourArray.count;
    }else{
        return self.futureDayArray.count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.futureHourTableView) {
        SPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HourCell"];
        cell.hourData = self.futureHourArray[indexPath.row];
        return cell;
    }else{
     SPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FutureCell"];
    cell.futureData = self.futureDayArray[indexPath.row];
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (iPhone6) {
        return 90.f;
    }else if (iPhone6_plus){
        return 100.f;
    }else{
        return 80.f;
    }
    
}
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y <= -60.f) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}
@end
