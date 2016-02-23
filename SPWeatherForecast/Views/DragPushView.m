//
//  DragPushView.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/22.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "DragPushView.h"
#import <Masonry.h>
@interface DragPushView()
@property (nonatomic,strong) UIImageView *actionView1;

@property (nonatomic,strong) UIImageView *actionView2;

@property (nonatomic,strong) UIImageView *actionView3;

@property (nonatomic,strong) NSTimer *timer;
@end
@implementation DragPushView


- (void)buildView{
    _actionView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dragIcon"]];
    _actionView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dragIcon"]];
    _actionView3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dragIcon"]];
    [self addSubview:_actionView1];
    [_actionView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(-8);
        make.size.mas_equalTo(CGSizeMake(40, 15));
    }];
    
    [self addSubview:_actionView2];
    [_actionView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(40, 15));
    }];
    
    [self addSubview:_actionView3];
    [_actionView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(8);
        make.size.mas_equalTo(CGSizeMake(40, 15));
    }];
    _actionView1.alpha = 0.f;
    _actionView2.alpha = 0.f;
    _actionView3.alpha = 1.f;
    self.timer = nil;
    
}
-(void)show{
    if (self.timer) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)startAnimation{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4 animations:^{
            _actionView3.alpha = 0.f;
            _actionView2.alpha = 1.f;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.4 animations:^{
                _actionView2.alpha = 0.f;
                _actionView1.alpha = 1.f;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.4 animations:^{
                    _actionView1.alpha = 0.f;
                    _actionView3.alpha = 1.f;
                } completion:nil];
            }];

                        NSLog(@"DragAction");
        }];
        
    });

    
}
-(void)hide{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
}
@end
