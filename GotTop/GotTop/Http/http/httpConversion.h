//
//  httpConversion.h
//  CarRental
//
//  Created by xiejiangbo on 2017/4/27.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol  httpConversionDelegate<NSObject>
-(void)getValue:(NSString*)value;
-(void)getGetCompanyValue:(NSString*)value;
-(void)getGetCompany:(NSMutableArray *)array;
@end
@interface httpConversion : NSObject
-(void)requestLogingWithParams:(NSString *)user and:(NSString*)psd;
-(void)requestLogingWithParams:(NSMutableDictionary *)params;
-(void)requestGetCompany;
@property(nonatomic,weak)id<httpConversionDelegate>delegate;
@property(nonatomic ,copy) HttpCallback callback;
@end
