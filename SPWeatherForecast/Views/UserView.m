//
//  UserView.m
//  SPWeatherForecast
//
//  Created by sheng on 16/2/18.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "UserView.h"

@implementation UserView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *headerImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"userHeaderImage"]];
        headerImageView.center = CGPointMake(frame.size.width/2, frame.size.height/4);
        headerImageView.bounds = CGRectMake(0, 0, 100, 100);
        [self addSubview:headerImageView];
        UIButton *button1 = [[UIButton alloc]init];
        button1.center = CGPointMake(frame.size.width/2, 2*frame.size.height/4);
        button1.bounds = CGRectMake(0, 0, 120, 35);
        button1.backgroundColor = [UIColor greenColor];
        [button1 setTitle:@"联系我" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button1.titleLabel.font = Font_STHeitiSC_Light(15);
        [self addSubview:button1];
        
        UIButton *button2 = [[UIButton alloc]init];
        button2.center = CGPointMake(frame.size.width/2, 2*frame.size.height/4+45);
        button2.bounds = CGRectMake(0, 0, 120, 35);
        button2.backgroundColor = [UIColor yellowColor];
        [button2 setTitle:@"QQ:277715243" forState:UIControlStateNormal];
        button2.titleLabel.font = Font_STHeitiSC_Light(15);
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:button2];
        
        UIButton *button3 = [[UIButton alloc]init];
        button3.center = CGPointMake(frame.size.width/2, 2*frame.size.height/4+90);
        button3.bounds = CGRectMake(0, 0, 120, 35);
        button3.backgroundColor = [UIColor redColor];
        [button3 setTitle:@"关闭程序" forState:UIControlStateNormal];
        [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button3.titleLabel.font = Font_STHeitiSC_Light(15);
        [button3 addTarget:self action:@selector(exitApplication) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button3];
        
    }
    return self;
}
- (void)exitApplication {
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    // [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view.window cache:NO];
    
    [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.window cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    //self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    
    self.window.bounds = CGRectMake(0, 0, 0, 0);
    
    [UIView commitAnimations];
    
}



- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        
        exit(0);
        
    }
    
}
@end
