
//
//  BaseHttpAPI.m
//  SHB1
//
//  Created by xiejiangbo on 2017/7/17.
//  Copyright © 2017年 yin chen. All rights reserved.
//
//#define kHomeBuyUrl @"10.1.225.49:7001/sapb1"//内网
//#define kHomeBuyUrl @"http://222.66.127.245/sapb1"//外网
#define kHomeBuyUrl @"http://222.66.127.246:7001/sapb1"//外网
#import "BaseHttpAPI.h"


@implementation BaseHttpAPI
+(void)requestLogingWithParams:(NSMutableDictionary *)params AndCallback:(MyCallback)callback{
     NSString *pathhh =[NSString stringWithFormat:@"%@/login",kHomeBuyUrl];
//    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
//    manager.securityPolicy=[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    manager.requestSerializer=[AFJSONRequestSerializer serializer];
//    manager.responseSerializer=[AFJSONResponseSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:@"1"forHTTPHeaderField:@"um"];
//    [manager POST:pathhh parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//       // NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        NSLog(@"dic===%@",responseObject);
//        int code = [[responseObject valueForKey: @"code"] intValue];
//        if ( code == 0 ) {
//
//            callback(@{
//                       @"result":[responseObject objectForKey:@"message"],
//                       @"content":[responseObject objectForKey:@"content"],
//                       });
//        }else {
//            callback(
//                     @{
//                       @"result":[responseObject objectForKey:@"message"],
//                       }
//                     );
//        }
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"errr====:%@",error);
//        callback(
//                 @{
//                   //@"result":@"服务器访问出错",
//                   @"result":@"请查看当前网络状态！",
//                   }
//                 );
//    }];
//
}
+(void)requestGetCompanyWithAndCallback:(MyCallback)callback{
    NSString *pathhh =[NSString stringWithFormat:@"%@/selectCompany",kHomeBuyUrl];
//    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
//
//    [manager GET:pathhh parameters:@"" success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        // NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        NSLog(@"dic===%@",responseObject);
//        int code = [[responseObject valueForKey: @"code"] intValue];
//        if ( code == 0 ) {
//            
//            callback(@{
//                       @"result":[responseObject objectForKey:@"message"],
//                       @"content":[responseObject objectForKey:@"content"],
//                       });
//        }else {
//            callback(
//                     @{
//                       @"result":[responseObject objectForKey:@"message"],
//                       }
//                     );
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"errr====:%@",error);
//        callback(
//                 @{
//                   //@"result":@"服务器访问出错",
//                   @"result":@"请查看当前网络状态！",
//                   }
//                 );
//    }];
//    
}

@end
