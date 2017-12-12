//
//  AccountInfoOC.m
//  SHYERP
//
//  Created by xiejiangbo on 2017/10/26.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "AccountInfoOC.h"

@implementation AccountInfoOC
+ (AccountInfoOC *)ShareAccountInfoOC{
    static AccountInfoOC *accountInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        accountInfo = [[AccountInfoOC alloc]init];

    });
    return accountInfo;
}
- (void)setStrUserId:(NSString *)companyDate
{
    [[NSUserDefaults standardUserDefaults] setObject:companyDate forKey:@"companyDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _companyData = companyDate;
}
- (void)setAuthorization:(NSString *)authorization
{
    [[NSUserDefaults standardUserDefaults] setObject:authorization forKey:@"authorization"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    _authorization = authorization;
}
- (void)setQrCodeData:(NSString *)qrCodeData
{
    [[NSUserDefaults standardUserDefaults] setObject:qrCodeData forKey:@"qrCodeData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _qrCodeData = qrCodeData;
}
- (void)setRemeberPassword:(NSString *)RemeberPassword
{
    [[NSUserDefaults standardUserDefaults] setObject:RemeberPassword forKey:@"RemeberPassword"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _RemeberPassword = RemeberPassword;
}
- (void)setPhoneNum:(NSString *)phoneNum
{
    [[NSUserDefaults standardUserDefaults] setObject:phoneNum forKey:@"phoneNum"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _phoneNum = phoneNum;
}
- (void)setPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _password = password;
}
- (void)setAutoLogin:(NSString *)AutoLogin
{
    [[NSUserDefaults standardUserDefaults] setObject:AutoLogin forKey:@"AutoLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _AutoLogin = AutoLogin;
}
- (void)setCompanyName:(NSString *)companyName
{
    [[NSUserDefaults standardUserDefaults] setObject:companyName forKey:@"companyName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _companyName = companyName;
}



@end
