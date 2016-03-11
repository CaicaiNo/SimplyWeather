//
//  SPSideMenuViewController.h
//  SPWeatherForecast
//
//  Created by sheng on 16/1/27.
//  Copyright © 2016年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "FutureViewController.h"
@interface SPSideMenuViewController : UIViewController

-(id)initWithMainViewController:(UIViewController *)mainVC andBackViewController:(UIViewController *)backVC;

@end
