//
//  TempView.m
//  SPWeatherForecast
//
//  Created by sheng on 15/12/31.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "TempView.h"
#import <POP.h>

@interface TempView()<NumberCountDelegate>
/**
 *  图片视图
 */
//@property (nonatomic,strong) UIImageView *tempImageView;
/**
 *  数值动画label
 */
@property (nonatomic,strong) UILabel *tempLabel;
/**
 *  动画引擎 count
 */
@property (nonatomic,strong) TempCount *tempCount;
/**
 *  标题label
 */
@property (nonatomic,strong) SPLabel *titleLabel;

@property (nonatomic,strong) UITapGestureRecognizer *tap;
@end
@implementation TempView
-(instancetype)init
{
    if (self = [super init]) {
        self.tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 120, 60)];
        self.tempLabel.alpha = 0.f;
//        self.tempLabel.backgroundColor = [UIColor grayColor];
        self.tempLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.tempLabel];
        
        self.tempCount = [TempCount new];
        self.tempCount.delegate = self;
    
        _titleLabel = [SPLabel initTitleLabelByText:@"Temperture"];
        [self addSubview:_titleLabel];
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        _tap.numberOfTapsRequired = 1;
        _tap.numberOfTouchesRequired= 1;
        [self.tempLabel addGestureRecognizer:_tap];
        self.tempLabel.userInteractionEnabled = YES;
        self.transform = CGAffineTransformTranslate(self.transform, -20, 0);
    
        self.alpha = 0.f;
       [self FitSizeAccrodingToScreen];
        
    }
    return self;
}
- (void)numberCount:(NumberCount *)numberCount currentSting:(NSAttributedString *)string{
    self.tempLabel.attributedText = string;
}
- (void)startAnimation{
    self.tempCount.fromValue = 100.f;
    self.tempCount.toValue = [self.temperture floatValue]?[self.temperture floatValue]:23;
    self.tempCount.duration = 2.f;
    [self.tempCount startAnimation];
    self.tempLabel.transform = CGAffineTransformMake(1.5, 0, 0, 1.5, 0, 0);
    
    [UIView animateWithDuration:2 animations:^{
        self.tempLabel.alpha = 1.f;
        self.tempLabel.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    } ];
}

- (void)stopAnimation{
    [self.layer removeAllAnimations];
}

- (void)hide{
    self.tempCount.fromValue = [self.temperture floatValue]?[self.temperture floatValue]:23;
    self.tempCount.toValue = 0.f;
    self.tempCount.duration = 2.f;
    [self.tempCount startAnimation];
    [UIView animateWithDuration:2 animations:^{
        self.alpha = 0.f;
        self.transform = CGAffineTransformTranslate(self.transform, -20, 0);
//        self.titleLabel.transform = CGAffineTransformTranslate(self.titleLabel.transform, -20, 0);

        
    }];
}

- (void)show{
    
//    self.tempLabel.transform = CGAffineTransformTranslate(self.tempLabel.transform, 20, 0);
    [UIView animateWithDuration:2 animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, 20, 0);
//        self.tempLabel.transform = CGAffineTransformTranslate(self.tempLabel.transform, -20, 0);
        self.alpha = 1.f;
    }];
    [self startAnimation];
}
- (void)tap:(UITapGestureRecognizer*)gesture;
{
    NSLog(@"click temperture");

}
@end
