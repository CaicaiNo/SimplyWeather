//
//  HLTempView.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/5.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "HLTempView.h"
#import "SPLabel.h"
#define Gap 20
@interface HLTempView()
@property (nonatomic,strong) UIImageView *highestTempView;
@property (nonatomic,strong) UIImageView *lowestTempView;
@property (nonatomic,strong) SPLabel *highestTempLabel;
@property (nonatomic,strong) SPLabel *lowestTempLabel;
@property (nonatomic,strong) UILabel *maxLabel;
@property (nonatomic,strong) UILabel *minLabel;
@property (nonatomic,strong) SPLabel *titleLabel;
@end
@implementation HLTempView
-(instancetype)init
{
    if (self = [super init]) {
        _highestTempView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Temperture_high"]];
        [self addSubview:_highestTempView];
        [_highestTempView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Gap);
            make.top.mas_equalTo(25);
            make.size.mas_equalTo(CGSizeMake(50, 75));
        }];
        
        
        _lowestTempView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Temperture_low"]];
        [self addSubview:_lowestTempView];
        [_lowestTempView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Gap);
            make.top.mas_equalTo(_highestTempView.mas_bottom).mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(50, 75));
        }];
        
        _maxLabel = [[UILabel alloc]init];
        _maxLabel.text = @"MAX:";
        _maxLabel.font = [UIFont fontWithName:LATO_REGULAR size:15];
       
        [self addSubview:_maxLabel];
        [_maxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_highestTempView.mas_right).mas_equalTo(0);
            make.top.mas_equalTo(_highestTempView);
            make.size.mas_equalTo(CGSizeMake(60, 30));
        }];
        _highestTempLabel = [SPLabel new];
        
        
        [self addSubview:_highestTempLabel];
        [_highestTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_highestTempView.mas_right).mas_equalTo(20);
            make.top.mas_equalTo(_maxLabel.mas_bottom).mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(40, 20));
        }];
        _minLabel = [UILabel new];
        _minLabel.text = @"MIN:";
        _minLabel.font = [UIFont fontWithName:LATO_REGULAR size:15];
        
        [self addSubview:_minLabel];
        [_minLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_lowestTempView.mas_right).mas_equalTo(0);
            make.top.mas_equalTo(_lowestTempView);
            make.size.mas_equalTo(CGSizeMake(60, 30));
        }];
        _lowestTempLabel = [SPLabel new];
        
        
        [self addSubview:_lowestTempLabel];
        [_lowestTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_lowestTempView.mas_right).mas_equalTo(20);
            make.top.mas_equalTo(_minLabel.mas_bottom).mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(40, 20));
        }];
        _titleLabel = [SPLabel initTitleLabelByText:@"Max/Min Temp"];
        [self addSubview:_titleLabel];
        
//        _maxLabel.alpha = 0.f;
//        _minLabel.alpha = 0.f;
//        _highestTempLabel.alpha = 0.f;
//        _lowestTempLabel.alpha = 0.f;
        self.alpha = 0.f;
        
//        _minLabel.backgroundColor = [UIColor greenColor];
//        _lowestTempLabel.backgroundColor = [UIColor greenColor];
//        _highestTempLabel.backgroundColor = [UIColor greenColor];
//        _maxLabel.backgroundColor = [UIColor greenColor];
        _highestTempView.transform = CGAffineTransformTranslate(_highestTempView.transform, -20, 0);
        _lowestTempView.transform = CGAffineTransformTranslate(_lowestTempView.transform, -20, 0);
        _maxLabel.transform = CGAffineTransformTranslate(_maxLabel.transform, -20, 0);
        _minLabel.transform = CGAffineTransformTranslate(_minLabel.transform, -20, 0);
        _highestTempLabel.transform = CGAffineTransformTranslate(_highestTempLabel.transform, 30, 0);
        _lowestTempLabel.transform = CGAffineTransformTranslate(_lowestTempLabel.transform, 30, 0);
        _titleLabel.transform = CGAffineTransformTranslate(_titleLabel.transform, -20, 0);
        [self FitSizeAccrodingToScreen];
    }
    return self;
}

-(void)show
{
    
    [_highestTempLabel setAttributedStringWithTemp:self.maxTemp?self.maxTemp:@15 andIsMax:YES];
    [_lowestTempLabel setAttributedStringWithTemp:self.minTemp?self.minTemp:@0 andIsMax:NO];
    
    [UIView animateWithDuration:2 animations:^{
        _maxLabel.transform = CGAffineTransformTranslate(_maxLabel.transform, 20, 0);
        _minLabel.transform = CGAffineTransformTranslate(_minLabel.transform, 20, 0);
        _highestTempLabel.transform = CGAffineTransformTranslate(_highestTempLabel.transform, -30, 0);
        _lowestTempLabel.transform = CGAffineTransformTranslate(_lowestTempLabel.transform, -30, 0);
        _highestTempView.transform = CGAffineTransformTranslate(_highestTempView.transform, 20, 0);
        _lowestTempView.transform = CGAffineTransformTranslate(_lowestTempView.transform, 20, 0);
         _titleLabel.transform = CGAffineTransformTranslate(_titleLabel.transform, 20, 0);
        self.alpha = 1.f;
        
    }];
    
}
-(void)hide
{
    
    [UIView animateWithDuration:2 animations:^{
        _maxLabel.transform = CGAffineTransformTranslate(_maxLabel.transform, -20, 0);
        _minLabel.transform = CGAffineTransformTranslate(_minLabel.transform, -20, 0);
         _titleLabel.transform = CGAffineTransformTranslate(_titleLabel.transform, -20, 0);
        _highestTempLabel.transform = CGAffineTransformTranslate(_highestTempLabel.transform, 30, 0);
        _lowestTempLabel.transform = CGAffineTransformTranslate(_lowestTempLabel.transform, 30, 0);
        _highestTempView.transform = CGAffineTransformTranslate(_highestTempView.transform, -20, 0);
        _lowestTempView.transform = CGAffineTransformTranslate(_lowestTempView.transform, -20, 0);
        self.alpha = 0.f;
        
    }];
}
-(void)startAnimation
{
    
}
-(void)stopAnimation
{
    
}
@end
