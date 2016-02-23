//
//  SPJuheManager.m
//  SPWeatherForest
//
//  Created by sheng on 15/12/29.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "SPJuheManager.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
@implementation SPJuheManager

static NSString *api_id = @"39";
static NSString *method = @"GET";

+(NSDictionary *)getRequestWithCityName:(NSString *)cityName
{
    NSString *path = @"http://v.juhe.cn/weather/index";
    NSDictionary *param = @{@"cityname":cityName, @"dtype":@"json"};
    return  [[self alloc] getRequestWithParam:param andPath:path];
    
}


+ (NSDictionary *)getCityList
{
    NSString *path = @"http://v.juhe.cn/weather/citys";
    NSDictionary *param = @{@"dtype":@"json"};
    return  [[self alloc]getRequestWithParam:param andPath:path];
}

+ (NSDictionary *)getWeatherCategory
{
    NSString *path = @"http://v.juhe.cn/weather/uni";
    NSDictionary *param = @{@"dtype":@"json"};
    return  [[self alloc]getRequestWithParam:param andPath:path];
}


+ (NSDictionary *)getThreeHoursForecastWithCityName:(NSString *)cityName
{
    NSString *path = @"http://v.juhe.cn/weather/forecast3h";
    NSDictionary *param = @{@"cityname":cityName, @"dtype":@"json"};
    return  [[self alloc]getRequestWithParam:param andPath:path];
}



+(NSDictionary *)getRequestWithLocation:(CLLocation *)location
{
    NSString *path = @"http://v.juhe.cn/weather/geo";
    NSDictionary *param = @{@"lon":[NSNumber numberWithFloat:location.coordinate.longitude], @"lat":[NSNumber numberWithFloat:location.coordinate.latitude],@"dtype":@"json"};
    return  [[self alloc]getRequestWithParam:param andPath:path];
}



- (NSDictionary *)getRequestWithParam:(NSDictionary *)param andPath:(NSString *)path
{
//    GCDSemaphore *semaphore = [GCDSemaphore init];
    NSCondition *SPLock = [[NSCondition alloc]init];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:@"JH9a90db989c0c56696cf12760663ee963"];
    });
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    __block NSDictionary *Dictionary = nil;
    [juheapi executeWorkWithAPI:path
                          APIID:api_id
                     Parameters:param
                         Method:method
                        Success:^(id responseObject){
//                            NSDictionary *dic = [NSDictionary new];
                                int error_code = [[responseObject objectForKey:@"error_code"] intValue];
                                if (!error_code) {
//                                    NSLog(@" %@", responseObject);
                                    [GCDQueue executeInGlobalQueue:^{
                                        Dictionary = responseObject;
                                    }];
                                    NSLog(@"成功获得JSON数据");
                                }else{
//                                    NSLog(@" %@", responseObject);
                                }
                            [SPLock lock];
                            [SPLock signal];
                            [SPLock unlock];
                            [TSMessage showNotificationWithTitle:@"更新成功" type:TSMessageNotificationTypeSuccess];
//                            [semaphore signal];
                        } Failure:^(NSError *error) {
                            NSLog(@"error:   %@",error.description);
                            [SPLock lock];
                            [SPLock signal];
                            [SPLock unlock];
                            [TSMessage showNotificationWithTitle:@"无法获取网络数据" subtitle:@"请检查网络状况" type:TSMessageNotificationTypeWarning];
                        }];
    [SPLock lock];
    [SPLock wait];
    [SPLock unlock];
    
//    [GCDQueue executeInGlobalQueue:^{
//        [semaphore wait];
//        NSLog(@"responseObj:%@",self.dictionary);
//    }];
   return Dictionary;
}
@end
