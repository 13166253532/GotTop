//
//  BaseHttpAPI.h
//  SHB1
//
//  Created by xiejiangbo on 2017/7/17.
//  Copyright © 2017年 yin chen. All rights reserved.
//
typedef void (^MyCallback)(id obj);
typedef void (^HttpCallback)(NSMutableArray *array);
#import <Foundation/Foundation.h>

@interface BaseHttpAPI : NSObject
+(void)requestLogingWithParams:(NSMutableDictionary *)params AndCallback:(MyCallback)callback;
+(void)requestGetCompanyWithAndCallback:(MyCallback)callback;
@end
