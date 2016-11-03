//
//  ZYCaptchaView.h
//  生成验证码demo
//
//  Created by tarena on 16/7/16.
//  Copyright © 2016年 张永强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYCaptchaView : UIView

/** 字符数组 */
@property (nonatomic , strong)NSArray *characterArray;

/** 验证码字符串 */
@property (nonatomic , strong)NSMutableString *captchaString;
/** 加载验证码 */
- (void)loadCaptcha;



@end
