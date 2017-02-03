//
//  VingVBLoginViewController.m
//  Vocabulary
//
//  Created by vingleo on 17/1/25.
//  Copyright © 2017年 Vingleo. All rights reserved.
//

#import "VingVBLoginViewController.h"
#import <CommonCrypto/CommonDigest.h>


@interface VingVBLoginViewController ()

@end

@implementation VingVBLoginViewController

/*
-(void)viewWillAppear:(BOOL)animated
{
    //_bgImage.alpha = 1;
    //添加指纹识别
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        NSLog(@"不支持指纹识别");
        return;
    }else{
        LAContext *ctx = [[LAContext alloc] init];
        ctx.localizedFallbackTitle = @"使用密码登录";
        if ([ctx canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
            NSLog(@"支持");
            [ctx evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"指纹识别" reply:^(BOOL success, NSError * error) {
                if (success) {
                    NSLog(@"识别成功");
                    [[NSOperationQueue mainQueue]addOperationWithBlock: ^(void)
                     {
                         //_bgImage.alpha = 0;
                     }];
                } else {
                    NSLog(@"识别失败");
                    switch (error.code) {
                        case LAErrorSystemCancel:
                            NSLog(@"系统取消指纹认证");
                            break;
                        case LAErrorUserCancel:
                        {
                            NSLog(@"用户取消指纹认证");
                            
                            [[NSOperationQueue mainQueue]addOperationWithBlock: ^(void)
                             {
                                 //_bgImage.alpha = 0.5;
                             }];
                            
                            
                            
                        }
                            break;
                        case LAErrorUserFallback:
                            NSLog(@"输入密码");
                            break;
                        case LAErrorPasscodeNotSet:
                            NSLog(@"输入密码");
                            break;
                        case LAErrorTouchIDNotEnrolled:
                            NSLog(@"没有设置touchID");
                            break;
                        case LAErrorTouchIDLockout:
                            NSLog(@"touchID被锁定");
                            break;
                        case LAErrorAppCancel:
                            NSLog(@"应用取消");
                            break;
                        case LAErrorInvalidContext:
                            NSLog(@"无效");
                            break;
                        case LAErrorTouchIDNotAvailable:
                            NSLog(@"touchID不可用");
                            break;
                        case LAErrorAuthenticationFailed:
                            NSLog(@"没有正确验证");
                            break;
                        default:
                            NSLog(@"Authentication failed");
                            break;
                    }
                }
            }];
        }
        
        //self.view.backgroundColor = [UIColor blackColor];
    }
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *username = [defaults stringForKey:@"registerUserNameKey"];
//    NSString *passWord = [defaults stringForKey:@"passWordKey"];
    NSArray *userInfo = [defaults objectForKey:@"userInfoKey"];
    
    NSString *username = [userInfo objectAtIndex:0];
    NSString *passWord = [userInfo objectAtIndex:1];
    
    _userNameTextField.text = username;
    _passwdTextField.text = passWord;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)registerBtnFuc:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([_userNameTextField.text isEqualToString:@""]||[_passwdTextField.text isEqualToString:@""] ) //([_passwdTextField.text isEqualToString:@""]) )
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Please enter your name and password" preferredStyle:UIAlertControllerStyleAlert];
        
        //alernate messge and title color
        NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:@"Warning"];
        [alertTitleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, 7)];
        [alertTitleStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 7)];
        [alert setValue:alertTitleStr forKey:@"attributedTitle"];
        
        NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:@"Please enter your name and password"];
        [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0,35)];
        [alertMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 35)];
        //可以指定不同的颜色
        //[alertMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(16, 22)];
        //[alertMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(23, 34)];
        [alert setValue:alertMessageStr forKey:@"attributedMessage"];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [cancelAction setValue:[UIColor blueColor] forKey:@"_titleTextColor"];
        
        [alert addAction:cancelAction];
        
        /*
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"I'm sure." style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:okAction];
         */
        [self presentViewController:alert animated:YES completion:nil];
        
        
    } else {
        [defaults setInteger:self.userID forKey:@"userIDKey"];
        [defaults setObject:_userNameTextField.text forKey: @"registerUserNameKey"];
        [defaults setObject:_passwdTextField.text forKey:@"passWordKey"];
        self.userID ++;
        [defaults synchronize];
    }
    
    
    
    
    
}
@end
