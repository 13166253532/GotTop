//
//  httpConversion.m
//  CarRental
//
//  Created by xiejiangbo on 2017/4/27.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "httpConversion.h"
#import "BaseHttpAPI.h"

@protocol CompanyInfor;
@interface CompanyInfor : JSONModel
@property NSString<Optional> *org_id;
@property NSString<Optional> *org_name;
@end
@implementation CompanyInfor
@end



@protocol BingCompanyContent;
@interface BingCompanyContent : JSONModel
@property NSMutableArray<CompanyInfor> *companyList;
@end
@implementation BingCompanyContent
@end




@implementation httpConversion
-(void)requestLogingWithParams:(NSMutableDictionary *)params{
    [BaseHttpAPI requestLogingWithParams:params AndCallback:^(id obj) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSLog(@"登陆-------%@",obj[@"result"]);
            if ([obj[@"content"] isEqualToString:@"Y"]) {
                NSMutableDictionary *dic = obj[@"content"];
                [self.delegate getValue:@"登录成功"];
            }else{
                [self.delegate getValue:@"登录失败！"];
            }
        }
    }];
}
-(void)requestGetCompany{
   [BaseHttpAPI requestGetCompanyWithAndCallback:^(id obj) {
       if ([obj isKindOfClass:[NSDictionary class]]) {
           NSLog(@"获取-------%@",obj[@"result"]);
           if ([obj[@"result"] isEqualToString:@"success"]) {
               NSMutableDictionary *dic = obj[@"content"];
               [self getCompanyArray:dic];
           }else{
               
               [self.delegate getGetCompanyValue:obj[@"result"]];
           }
       }
   }];
}
-(void)getCompanyArray:(NSMutableDictionary *)dic{
    
    NSMutableArray *httpArray = [NSMutableArray array];
    BingCompanyContent *content = [[BingCompanyContent alloc]initWithDictionary:dic error:nil];
    for (int i = 0; i<content.companyList.count; i++) {
        CompanyInfor *companyInfor = content.companyList[i];
//        CompanyListInfoMode *companyListInfoMode = [[CompanyListInfoMode alloc]init];
//        companyListInfoMode.org_id = companyInfor.org_id;
//        companyListInfoMode.org_name = companyInfor.org_name;
//        [httpArray addObject:companyListInfoMode];
    }
    NSMutableArray *array1 = [NSMutableArray array];
    NSMutableArray *array = [dic objectForKey:@"companyList"];
    for (int i = 0; i<array.count; i++) {
        NSMutableDictionary *dic = array[i];
        [array1 addObject:[dic objectForKey:@"org_id"]];
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array1 options:NSJSONWritingPrettyPrinted error:&parseError];
    //[AccountInfo sharedInstance].companyData = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    self.callback(httpArray);
}

@end
