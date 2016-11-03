//
//  ViewController.m
//  生成验证码demo
//
//  Created by tarena on 16/7/16.
//  Copyright © 2016年 张永强. All rights reserved.
//

#import "ViewController.h"
#import "ZYCaptchaView.h"

@interface ViewController ()

/** 验证码视图 */
@property (nonatomic , strong)ZYCaptchaView *captchaView;
/** 输入框 */
@property (nonatomic , strong)UITextField *inputField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView];
}
- (void)creatView {
    self.captchaView = [[ZYCaptchaView alloc] initWithFrame:CGRectMake(30, 140, 160, 40)];
    [self.view addSubview:self.captchaView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(200, 140, 100, 40);
   
    [button setTitle:@"切换验证码" forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor blueColor].CGColor;
    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = 5.0;
    button.titleLabel.font=[UIFont systemFontOfSize:14];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button addTarget:self action:@selector(changeCaptcha) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //添加输入框
    self.inputField = [[UITextField alloc]initWithFrame:CGRectMake(30, 200, 160, 40)];
    self.inputField.layer.borderColor = [UIColor orangeColor].CGColor;
    self.inputField.layer.borderWidth = 1.0;
    self.inputField.layer.cornerRadius = 5.0;
    self.inputField.font = [UIFont systemFontOfSize:12];
     self.inputField.placeholder = @"请输入验证码,不区分大小写!";
    self.inputField.backgroundColor = [UIColor clearColor];
    self.inputField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.inputField];
    //添加验证按钮
    UIButton *captchaButton=[[UIButton alloc]initWithFrame:CGRectMake(200, 200, 100, 40)];
    captchaButton.backgroundColor=[UIColor greenColor];
    [captchaButton setTitle:@"验证" forState:UIControlStateNormal];
    captchaButton.titleLabel.font=[UIFont systemFontOfSize:14];
    captchaButton.layer.borderColor = [UIColor orangeColor].CGColor;
    captchaButton.layer.borderWidth = 1.0;
    captchaButton.layer.cornerRadius = 5.0;
    [captchaButton addTarget:self action:@selector(captchaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:captchaButton];
}
- (void)changeCaptcha {
    self.inputField.text = @"";
    [self.captchaView loadCaptcha];
}
#pragma mark --验证按钮
- (void)captchaBtnClick {
    //不区分大小写
    self.inputField.text = [self toLower:self.inputField.text];
    self.captchaView.captchaString = [[self toLower:self.captchaView.captchaString] copy];
    if ([self.inputField.text isEqualToString:self.captchaView.captchaString]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"恭喜您 ^o^" message:@"验证成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
        [self.captchaView loadCaptcha];
    }else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"不好意思" message:@"验证失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
        [_captchaView loadCaptcha];
        self.inputField.text = @"";
        //验证不匹配，验证码和输入框晃动
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [_captchaView.layer addAnimation:anim forKey:nil];
        [_inputField.layer addAnimation:anim forKey:nil];
    }
}
/** 大写字母转换为小写 */
- (NSString *)toLower:(NSString *)str {
    for (int i = 0; i < str.length; i++) {
        if ([str characterAtIndex:i] >= 'A' && [str characterAtIndex:i] <= 'Z') {
            char temp = [str characterAtIndex:i] + 32;
            NSRange range = NSMakeRange(i, 1);
            str = [str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c" , temp]];
        }
    }
    return str;
}
/** 小写字母转换为大写 */
-(NSString *)toUpper:(NSString *)str{
    for (int i = 0; i < str.length; i++) {
        if ([str characterAtIndex:i]>='a'&[str characterAtIndex:i]<='z') {
            char  temp=[str characterAtIndex:i]-32;
            NSRange range=NSMakeRange(i, 1);
            str=[str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}

@end
