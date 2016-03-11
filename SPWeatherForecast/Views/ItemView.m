//
//  ItemView.m
//  SPWeatherForecast
//
//  Created by sheng on 15/12/31.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "ItemView.h"

@implementation ItemView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];

        [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(150, 150));
        }];
      
        
    }
    return self;
}

@end
