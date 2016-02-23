//
//  TipsView.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/5.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "TipsView.h"
@interface TipsView()
/**
 *  标题label
 */
@property (nonatomic,strong) SPLabel *titleLabel;

@property (nonatomic,strong) SPLabel *dressingLabel;

@property (nonatomic,strong) SPLabel *uvLabel;

@property (nonatomic,strong) SPLabel *washLabel;

@property (nonatomic,strong) SPLabel *travelLabel;

@property (nonatomic,strong) SPLabel *exerciseLabel;

@end
@implementation TipsView

- (instancetype)init
{
    if (self = [super init]) {
        _titleLabel = [SPLabel initTitleLabelByText:@"Tips"];
        [self addSubview:_titleLabel];
        _dressingLabel = [[SPLabel alloc]init];
        
        [self addSubview:_dressingLabel];
        [_dressingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(_titleLabel.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(15);
        }];
        _uvLabel = [[SPLabel alloc]init];
        
        [self addSubview:_uvLabel];
        [_uvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(_dressingLabel.mas_bottom).mas_equalTo(5);
            make.height.mas_equalTo(15);
        }];
        _washLabel = [[SPLabel alloc]init];
       
        [self addSubview:_washLabel];
        [_washLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(_uvLabel.mas_bottom).mas_equalTo(5);
            make.height.mas_equalTo(15);
        }];
        _travelLabel = [[SPLabel alloc]init];
        
        [self addSubview:_travelLabel];
        [_travelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(_washLabel.mas_bottom).mas_equalTo(5);
            make.height.mas_equalTo(15);
        }];
        _exerciseLabel = [[SPLabel alloc]init];
        
        [self addSubview:_exerciseLabel];
        [_exerciseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(_travelLabel.mas_bottom).mas_equalTo(5);
            make.height.mas_equalTo(15);
        }];
        self.transform = CGAffineTransformTranslate(self.transform, -20, 0);
        self.alpha = 0.f;
        [self FitSizeAccrodingToScreen];
    }
    return self;
}

-(void)show
{
    
        [_dressingLabel setTipsLabelByText:[NSString stringWithFormat:@"穿衣指数:%@",self.tipsData.dressing_index]];
        [_uvLabel setTipsLabelByText:[NSString stringWithFormat:@"紫外线强度:%@",self.tipsData.uv_index]];
        [_washLabel setTipsLabelByText:[NSString stringWithFormat:@"洗车指数:%@",self.tipsData.wash_index]];
        [_travelLabel setTipsLabelByText:[NSString stringWithFormat:@"旅游指数:%@",self.tipsData.travel_index]];
        [_exerciseLabel setTipsLabelByText:[NSString stringWithFormat:@"锻炼指数:%@",self.tipsData.exercise_index]];

    
    [UIView animateWithDuration:2 animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, 20, 0);
        //        self.tempLabel.transform = CGAffineTransformTranslate(self.tempLabel.transform, -20, 0);
        self.alpha = 1.f;
    }];

}
-(void)hide
{
    [UIView animateWithDuration:2 animations:^{
        self.alpha = 0.f;
        self.transform = CGAffineTransformTranslate(self.transform, -20, 0);
        //        self.titleLabel.transform = CGAffineTransformTranslate(self.titleLabel.transform, -20, 0);
        
        
    }];
}
@end
