//
//  SPDataManager.h
//  SPWeatherForest
//
//  Created by sheng on 15/12/29.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "FontInfomation.h"

static NSMutableDictionary *_systemFontDictionary = nil; // 系统字体信息

@implementation FontInfomation

+ (void)initialize {
    if (self == [FontInfomation class]) {
        _systemFontDictionary = [[NSMutableDictionary alloc] init];
        
        // 获取系统字体族
        [FontInfomation getSystemFontList];
    }
}

+ (void)getSystemFontList {
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames) {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        [_systemFontDictionary setObject:fontNames forKey:familyName];
    }
}

+ (NSDictionary *)systomFontNameList {
    return [NSDictionary dictionaryWithDictionary:_systemFontDictionary];
}

@end
