//
//  LoginViewController.m
//  GotTop
//
//  Created by xiejiangbo on 2017/12/12.
//  Copyright © 2017年 yin chen. All rights reserved.
//
typedef enum {
    ONE = 0,
    TWO,
    THREE,
} SYB1Version;
#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate,httpConversionDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    UILabel*lbco;
    UILabel*lbl;
    UILabel*lbl2;
    UIImageView*imgban;
    MBProgressHUD *hud;
    httpConversion *httpApi;
    SYB1Version *syb1Version;
    NSString *selectCompanTitle;
    UIPickerView *pickView;
}
@property (strong, nonatomic)  UIView *pickBagView;
@property (strong, nonatomic)  UIButton *selectBtn;
@property (strong, nonatomic)  UIButton *buttonLogin;
@property (strong, nonatomic)  UIButton *buttonRemeberPassword;
@property (strong, nonatomic)  UIButton *buttonAutoLogin;
@property (strong, nonatomic)  UITextField *textFieldUserName;
@property (strong, nonatomic)  UITextField *textFieldPassword;
@property (strong, nonatomic)  UITextField *textFieldCompany;
@property (strong, nonatomic)  UIImageView *imageViewUser;
@property (strong, nonatomic)  UIImageView *bagImageView;
@property (strong, nonatomic)  UIImageView *titeImageView;
@property (strong, nonatomic)  UIImageView *textFieldImage;
@property (strong, nonatomic)  UIImageView *lineImage;
@property (strong, nonatomic)  UIImageView *twoLineImage;
@property (strong, nonatomic)  NSMutableArray *companyArray;
@end

@implementation LoginViewController
+(LoginViewController *)createViewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginViewController" bundle:nil];
    LoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    httpApi = [[httpConversion alloc]init];
    httpApi.delegate = self;
    self.companyArray = [NSMutableArray array];
    syb1Version = ONE;
    [self addtiteImageView];
    [self addtextFieldImage];
    [self addlineImage];
    [self addtextFieldView];
    [self setBtn];
    
    if (syb1Version != ONE) {
        [self addUIPickerView];
        [httpApi requestGetCompany];
        __weak typeof(self) weakSelf = self;
        httpApi.callback = ^(NSMutableArray *array) {
            weakSelf.companyArray = array;
        };
    }
    hud = [[MBProgressHUD alloc] init];
    [self.view addSubview: hud];
    [hud setMode: MBProgressHUDModeText];
    
}
-(void)getGetCompanyValue:(NSString *)value{
    [hud setLabelText: value];
    [hud show: YES];
    [hud hide: YES afterDelay: 1.5f];
}
- (void)viewWillAppear:(BOOL)animated{
    
    if ([[AccountInfoOC ShareAccountInfoOC].RemeberPassword isEqualToString:@"1"]) {
        _buttonRemeberPassword.selected = YES;
        _textFieldUserName.text = [AccountInfoOC ShareAccountInfoOC].phoneNum;
        _textFieldPassword.text = [AccountInfoOC ShareAccountInfoOC].password;
    }
    if ([[AccountInfoOC ShareAccountInfoOC].AutoLogin isEqualToString:@"1"] && ![self isBlankString:[AccountInfoOC ShareAccountInfoOC].companyName]) {
        _buttonAutoLogin.selected = YES;
        _textFieldUserName.text = [AccountInfoOC ShareAccountInfoOC].phoneNum;
        _textFieldPassword.text = [AccountInfoOC ShareAccountInfoOC].password;
        [self loginHttp];
    }else if ([[AccountInfoOC ShareAccountInfoOC].AutoLogin isEqualToString:@"1"] && [self isBlankString:[AccountInfoOC ShareAccountInfoOC].companyName]){
        [hud setLabelText: @"公司名不能为空"];
        [hud show: YES];
        [hud hide: YES afterDelay: 1.5f];
   }
    
}
- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
-(void)addbagImageView{
    _bagImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _bagImageView.image = [UIImage imageNamed:@"bagImageView"];
    _bagImageView.userInteractionEnabled = YES;
    [self.view addSubview:_bagImageView];
}
-(void)addtiteImageView{
    _titeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kDcalHeight*80, kDcalWide*180, kDcalHeight*75)];
    _titeImageView.contentMode = UIViewContentModeScaleAspectFit;
    _titeImageView.centerX = SCREEN_WHIDTH/2;
    _titeImageView.image = [UIImage imageNamed:@"titeImageView"];
    [self.view addSubview:_titeImageView];
}
-(void)addtextFieldImage{
    if (syb1Version == ONE) {
        _textFieldImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, _titeImageView.height+_titeImageView.originX+kDcalHeight*15, SCREEN_WHIDTH-30, kDcalHeight*100)];
    }else{
        _textFieldImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, _titeImageView.height+_titeImageView.originX+kDcalHeight*15, SCREEN_WHIDTH-30, kDcalHeight*150)];
    }
    _textFieldImage.centerX = SCREEN_WHIDTH/2;
    _textFieldImage.image = [UIImage imageNamed:@"textFieldImage"];
    [self.view addSubview:_textFieldImage];
}
-(void)addlineImage{
    _lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(_textFieldImage.originX+ kDcalWide*5, 0, _textFieldImage.width-kDcalWide*10, 1)];
    
    _lineImage.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:_lineImage];
    if (syb1Version == ONE) {
        _lineImage.centerY = _textFieldImage.centerY;
    }else{
        _lineImage.centerY = _textFieldImage.centerY-_textFieldImage.height/2+_textFieldImage.height/3;
        _twoLineImage = [[UIImageView alloc]initWithFrame:CGRectMake(_textFieldImage.originX+ kDcalWide*5, 0, _textFieldImage.width-kDcalWide*10, 1)];
        _twoLineImage.centerY = _textFieldImage.centerY-_textFieldImage.height/2+_textFieldImage.height/3*2;
        _twoLineImage.image = [UIImage imageNamed:@"line"];
        [self.view addSubview:_twoLineImage];
    }
    
}

- (void)addtextFieldView{
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(_lineImage.originX+kDcalWide*15, _textFieldImage.originY+kDcalWide*16, kDcalHeight*20, kDcalHeight*20)];
    image1.image = [UIImage imageNamed:@"userImage"];
    [self.view addSubview:image1];
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(_lineImage.originX+kDcalWide*15, _lineImage.originY+kDcalWide*16, kDcalHeight*20, kDcalHeight*20)];
    image2.image = [UIImage imageNamed:@"passWordImage"];
    
    [self.view addSubview:image2];
    
    self.textFieldUserName = [self getTextField:@"请输入账号" andTag:100];
    self.textFieldPassword = [self getTextField:@"请输入密码" andTag:101];
    self.textFieldCompany = [self getTextField:@"请输入公司名" andTag:102];
    if (syb1Version == ONE) {
        self.textFieldUserName.frame = CGRectMake(image1.originX+kDcalWide*10+image1.width, _textFieldImage.originY+kDcalHeight*6, _textFieldImage.width-(image1.originX+kDcalWide*10+image1.width), _textFieldImage.height/2-kDcalHeight*6);
        self.textFieldPassword.frame = CGRectMake(image1.originX+kDcalWide*10+image1.width, _lineImage.originY, _textFieldImage.width-(image1.originX+kDcalWide*10+image1.width), _textFieldImage.height/2-kDcalHeight*6);
    }else{
        
        UIImageView *image3 = [[UIImageView alloc]initWithFrame:CGRectMake(_twoLineImage.originX+kDcalWide*15, _twoLineImage.originY+kDcalWide*10, kDcalHeight*20, kDcalHeight*20)];
        image3.image = [UIImage imageNamed:@"company"];
        [self.view addSubview:image3];
        self.textFieldUserName.frame = CGRectMake(image1.originX+kDcalWide*10+image1.width, _textFieldImage.originY+kDcalHeight*6, _textFieldImage.width-(image1.originX+kDcalWide*10+image1.width), _textFieldImage.height/3-kDcalHeight*6);
        self.textFieldPassword.frame = CGRectMake(image1.originX+kDcalWide*10+image1.width, _lineImage.originY, _textFieldImage.width-(image1.originX+kDcalWide*10+image1.width), _textFieldImage.height/3-kDcalHeight*6);
        self.textFieldCompany.frame = CGRectMake(image1.originX+kDcalWide*10+image1.width, _twoLineImage.originY, _textFieldImage.width-(image1.originX+kDcalWide*10+image1.width), _textFieldImage.height/3-kDcalHeight*6);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = self.textFieldCompany.frame;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(handleSwipeFrom:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.textFieldCompany];
        [self.view addSubview:btn];
        
        
    }
    self.textFieldPassword.secureTextEntry = YES;
    [self.view addSubview:self.textFieldUserName];
    [self.view addSubview:self.textFieldPassword];
}
-(void)handleSwipeFrom:(UIButton *)sender{
    //NSLog(@"%@",[AccountInfo sharedInstance].companyData);
    if ([self isBlankString:[AccountInfoOC ShareAccountInfoOC].companyData]) {
        [hud setLabelText: @"请查看当前网络状态！"];
        [hud show: YES];
        [hud hide: YES afterDelay: 1.5f];
    }else{
        [pickView reloadAllComponents];
        pickView.hidden = NO;
        _selectBtn.hidden = NO;
        _pickBagView.hidden = NO;
    }
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textFieldCompany resignFirstResponder];
    [self.textFieldPassword resignFirstResponder];
    [self.textFieldUserName resignFirstResponder];
}
-(UITextField *)getTextField:(NSString *)placeholder andTag:(NSInteger)tag{
    UITextField *text = [[UITextField alloc]init];
    text.placeholder = placeholder;
    text.font=[UIFont systemFontOfSize:15.f];
    text.clearButtonMode = UITextFieldViewModeWhileEditing;
    text.delegate=self;
    text.tag = tag;
    //text.backgroundColor = [UIColor redColor];
    return text;
}
-(void)setBtn{
    self.buttonRemeberPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonRemeberPassword.contentMode = UIViewContentModeScaleToFill;
    self.buttonRemeberPassword.frame = CGRectMake(_textFieldImage.originX+kDcalWide*35, _textFieldImage.originY+_textFieldImage.height+kDcalHeight*5, kDcalWide*20, kDcalWide*20);
    [self.buttonRemeberPassword setBackgroundImage:[UIImage imageNamed:@"false"] forState:0];
    [self.buttonRemeberPassword setBackgroundImage:[UIImage imageNamed:@"true"] forState:UIControlStateSelected];
    [self.buttonRemeberPassword setBackgroundImage:[UIImage imageNamed:@"true"] forState:UIControlStateHighlighted];
    [self.buttonRemeberPassword addTarget:self action:@selector(clileft:) forControlEvents:UIControlEventTouchUpInside];
  
    [self.view addSubview:self.buttonRemeberPassword];
    self.buttonAutoLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonAutoLogin.frame = CGRectMake(_textFieldImage.originX+kDcalWide*185, _textFieldImage.originY+_textFieldImage.height+kDcalHeight*5, kDcalWide*20, kDcalWide*20);
    self.buttonAutoLogin.contentMode = UIViewContentModeScaleToFill;
    [self.buttonAutoLogin setBackgroundImage:[UIImage imageNamed:@"false"] forState:0];
    [self.buttonAutoLogin setBackgroundImage:[UIImage imageNamed:@"true"] forState:UIControlStateSelected];
    [self.buttonAutoLogin setBackgroundImage:[UIImage imageNamed:@"true"] forState:UIControlStateHighlighted];
    [self.buttonAutoLogin addTarget:self action:@selector(cliright:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonAutoLogin];
    
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(self.buttonRemeberPassword.originX+kDcalWide*20,0, kDcalWide*120, kDcalHeight*23)];
    lbl.text = @"保存账号密码";
    lbl.centerY=self.buttonRemeberPassword.centerY;
    lbl.textColor=[UIColor darkGrayColor];
    lbl.font=[UIFont systemFontOfSize:14.f];
    [self.view addSubview:lbl];
    
    lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(self.buttonAutoLogin.originX+kDcalWide*20,0, kDcalWide*100, kDcalHeight*23)];
    lbl2.centerY=self.buttonAutoLogin.centerY;
    lbl2.text = @"自动登录";
    lbl2.textColor=[UIColor darkGrayColor];
    lbl2.font=[UIFont systemFontOfSize:14.f];
    [self.view addSubview:lbl2];
    
    self.buttonLogin=[[UIButton alloc]initWithFrame:CGRectMake(0, lbl2.originY+lbl2.height+kDcalWide*80, _textFieldImage.width-30, kDcalWide*35)];
    self.buttonLogin.centerX=SCREEN_WHIDTH/2;
    UIImage *redButton = [UIImage imageNamed:@"登录-切图_53.png"];
    [self.buttonLogin setBackgroundImage:redButton forState:UIControlStateNormal];
    [self.buttonLogin setTitle:@"登录" forState:0];
    self.buttonLogin.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.buttonLogin addTarget:self action:@selector(onLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonLogin];
    
}
-(void)clileft:(id)sender {
    self.buttonRemeberPassword.selected = !self.buttonRemeberPassword.selected;
    if (!self.buttonRemeberPassword.selected) {
        self.buttonAutoLogin.selected = NO;
    }
    
}
-(void)cliright:(id)sender{
    self.buttonAutoLogin.selected = !self.buttonAutoLogin.selected;
    self.buttonRemeberPassword.selected = YES;
}
- (void)onLogin:(id)sender {
    [self.textFieldUserName resignFirstResponder];
    [self.textFieldPassword resignFirstResponder];
    [self.textFieldCompany resignFirstResponder];
    
    if ( !self.textFieldUserName.text.length ) {
        [hud setLabelText: @"账号不能为空"];
        [hud show: YES];
        [hud hide: YES afterDelay: 1.5f];
        return ;
    }
    if ( !self.textFieldPassword.text.length ) {
        [hud setLabelText: @"密码不能为空"];
        [hud show: YES];
        [hud hide: YES afterDelay: 1.5f];
        
        return ;
    }
    if (syb1Version != ONE) {
        if ( !self.textFieldCompany.text.length ) {
            [hud setLabelText: @"公司名不能为空"];
            [hud show: YES];
            [hud hide: YES afterDelay: 1.5f];
            return ;
        }
    }
    
    [self loginHttp];
    
}
-(void)loginHttp{
    
    NSMutableDictionary*params=[[NSMutableDictionary alloc]init];
    [params setValue:self.textFieldUserName.text forKey:@"userid"];
    [params setValue:self.textFieldPassword.text forKey:@"password"];
    [httpApi requestLogingWithParams:params];
    
}
-(void)getValue:(NSString *)value{
    if ([value isEqualToString:@"登录成功"]) {
        [AccountInfoOC ShareAccountInfoOC].phoneNum = self.textFieldUserName.text;
        [self setRemeberPasswordAndAutoLogin];
        [hud setMode: MBProgressHUDModeIndeterminate];
        [hud setLabelText: @"正在登录"];
        [hud show: YES];
        [self gotuWebVC];
    }else{
        [hud  setLabelText:  value];
        [hud show: YES];
        [hud hide: YES afterDelay: 1.5f];
    }
}
-(void)gotuWebVC{
    [hud hide: YES afterDelay: 1.5f];
    WebViewController *web = [[WebViewController alloc]init];
    [self presentViewController:web animated:YES completion:nil];
    //[self.navigationController pushViewController:web animated:YES];
}
-(void)setRemeberPasswordAndAutoLogin{
    if (self.buttonRemeberPassword.selected) {
        [AccountInfoOC ShareAccountInfoOC].RemeberPassword = @"1";
    }
    if (self.buttonAutoLogin.selected) {
        [AccountInfoOC ShareAccountInfoOC].AutoLogin = @"1";
    }
    if (syb1Version != ONE) {
        [AccountInfoOC ShareAccountInfoOC].companyName = self.textFieldCompany.text;
    }
    [AccountInfoOC ShareAccountInfoOC].phoneNum = self.textFieldUserName.text;
    [AccountInfoOC ShareAccountInfoOC].password = self.textFieldPassword.text;
    
}

-(void)addUIPickerView{
    //    self.companyArray = [NSMutableArray array];
    //    for (int i=0; i<5; i++) {
    //        [self.companyArray addObject:[NSString stringWithFormat:@"%d",i]];
    //    }
    //        NSData *jsonDatas = [[AccountInfo sharedInstance].companyData dataUsingEncoding:NSUTF8StringEncoding];
    //        NSError *err;
    //
    //        self.companyArray = [NSJSONSerialization JSONObjectWithData:jsonDatas
    //                                                            options:NSJSONReadingMutableContainers
    //                                                              error:&err];
    NSLog(@"%@",self.companyArray);
    _pickBagView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WHIDTH, SCREEN_HEIGHT)];
    _pickBagView.backgroundColor = UICOLORFROMRGB(0x666666);
    _pickBagView.alpha = 0.4;
    [self.view addSubview:_pickBagView];
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectBtn.frame = CGRectMake(0, SCREEN_HEIGHT-_textFieldCompany.height*5, SCREEN_WHIDTH, _textFieldCompany.height-2);
    _selectBtn.backgroundColor = [UIColor whiteColor];
    //_selectBtn.alpha = 0.5;
    [_selectBtn setTitle:@"确  定" forState:UIControlStateNormal];
    _selectBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [_selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_selectBtn addTarget:self action:@selector(selecAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selectBtn];
    
    
    pickView = [[UIPickerView alloc]init];
    pickView.frame = CGRectMake(0,SCREEN_HEIGHT-_textFieldCompany.height*4, SCREEN_WHIDTH, _textFieldCompany.height*4);
    pickView.backgroundColor = [UIColor whiteColor];
    pickView.delegate = self;
    pickView.dataSource = self;
    [self.view addSubview:pickView];
    
    pickView.hidden = YES;
    _selectBtn.hidden = YES;
    _pickBagView.hidden = YES;
}
-(void)selecAction:(UIButton *)sender{
    self.textFieldCompany.text = selectCompanTitle;
    pickView.hidden = YES;
    _selectBtn.hidden = YES;
    _pickBagView.hidden = YES;
}

#pragma mark UIPickerViewDataSource 数据源方法
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return self.textFieldCompany.height;
}
// 返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
// 返回多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    //NSLog(@"-----%ld",(unsigned long)self.companyArray.count);
    return self.companyArray.count;
}
//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)componen{
//    CompanyListInfoMode *model = self.companyArray[0];
//    selectCompanTitle = model.org_name;
//    [AccountInfo sharedInstance].companyId = model.org_id;
//    CompanyListInfoMode *model1 = self.companyArray[row];
//    //NSLog(@"===%@",str);
//    return model1.org_name;
//}

//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    NSLog(@"self.companyArray===%@",self.companyArray[row]);
//    selectCompanTitle = [NSString stringWithFormat:@"%@",self.companyArray[row]];
//    CompanyListInfoMode *model1 = self.companyArray[row];
//    selectCompanTitle = model1.org_name;
//    [AccountInfo sharedInstance].companyId = model1.org_id;
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
