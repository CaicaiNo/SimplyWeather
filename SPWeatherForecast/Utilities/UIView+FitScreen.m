//
//  UIView+FitScreen.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/8.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "UIView+FitScreen.h"

@implementation UIView (FitScreen)
- (void)FitSizeAccrodingToScreen{
    if (iPhone6_plus) {
        self.transform = CGAffineTransformMake(1.3,0,0,1.3,0,0);
        
    }else if (iPhone6){
        self.transform = CGAffineTransformMake(1.1,0,0,1.1,0,0);
    }
}
@end
