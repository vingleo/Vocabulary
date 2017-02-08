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
    _lastTag = [defaults integerForKey:@"lastTagKey"];
    NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%ld",(long)_lastTag];
    NSArray *currentUserArray = [defaults objectForKey:userArrayKey];
    
    NSString *username = [currentUserArray objectAtIndex:0];
    NSString *passWord = [currentUserArray objectAtIndex:1];
    
    if(_lastTag) {
        _userNameTextField.text = username;
        _passwdTextField.text = passWord;

    } else {
        _userNameTextField.text = @"";
        _passwdTextField.text = @"";
        //_lastTag = 0;
    }
    
    NSLog(@"View Did Load lastTagKey is %ld",_lastTag);
    NSLog(@"View Did Load username is %@",username);
    NSLog(@"View Did Load passWord is %@",passWord);


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
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%ld",(long)_currentTag];
    //NSArray *currentUserArray = [defaults objectForKey:userArrayKey];
    
                                 
    //NSString *currentUser = [currentUserArray objectAtIndex:0];
    //NSString *currentPasswd = [currentUserArray objectAtIndex:1];
    
    //NSLog(@"***********This is currentUser:%@",currentUser);
    
    
    //判断用户名为空BOOL 1
    if ([_userNameTextField.text isEqualToString:@""]) //([_passwdTextField.text isEqualToString:@""]) )
    {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Please enter your name" preferredStyle:UIAlertControllerStyleAlert];
        
        //alernate messge and title color
        NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:@"Warning"];
        [alertTitleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, 7)];
        [alertTitleStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 7)];
        [alert setValue:alertTitleStr forKey:@"attributedTitle"];
        
        NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:@"Please enter your name"];
        [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0,22)];
        [alertMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,22)];
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
        //判断密码为空 BOOL 2
        if ([_passwdTextField.text isEqualToString:@""] ) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Please enter your password" preferredStyle:UIAlertControllerStyleAlert];
            
            //alernate messge and title color
            NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:@"Warning"];
            [alertTitleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, 7)];
            [alertTitleStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 7)];
            [alert setValue:alertTitleStr forKey:@"attributedTitle"];
            
            NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:@"Please enter your password"];
            [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0,26)];
            [alertMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,26)];
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
          }
        else {
            //判断是否和现有用户重复 BOOL 3
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            _lastTag = [defaults integerForKey:@"lastTagKey"];

            //判断是否存在UserDefaults文件
            if (_lastTag) {
                for (int i=1; i<=_lastTag; i++)
                    
                {
                    
                    
                    NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%d",i];
                    NSArray *array = [defaults objectForKey:userArrayKey];
                    NSString *user = [array objectAtIndex:0];
                    NSLog(@"Inside loop user is %@",user);
                    NSMutableArray *allUsersArray=[[NSMutableArray alloc]init];
                    
                    [allUsersArray addObject:user];
                    NSLog(@"Inside loop allUsersArray is %@",allUsersArray);
                    
                    //if([allUsersArray containsObject:_userNameTextField.text])
                    if([allUsersArray containsObject:_userNameTextField.text]                                                                                                                                                                                                                                                                                                                                  )
                    {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"User Exists, Please change name" preferredStyle:UIAlertControllerStyleAlert];
                        //alernate messge and title color
                        NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:@"Warning"];
                        [alertTitleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, 7)];
                        [alertTitleStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 7)];
                        [alert setValue:alertTitleStr forKey:@"attributedTitle"];
                        
                        NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:@"User Exists, \nPlease change name"];
                        [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0,32)];
                        [alertMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 32)];
                        [alert setValue:alertMessageStr forKey:@"attributedMessage"];
                        
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
                        [alert addAction:cancelAction];
                        [self presentViewController:alert animated:YES completion:nil];
                        //[self performSegueWithIdentifier:@"backMainView" sender:self];
                        
                    }
                    
                }
                
                
                
                
            }
            
            
            //UserDefaults file doesn't exist.
            else {
                //设lastTag
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                _lastTag = [defaults integerForKey:@"lastTagKey"];
                NSLog(@"After lastTag is %ld",_lastTag);
                
                NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%ld",(long)_lastTag+1];
                
                NSArray *currentUserArray = [NSArray arrayWithObjects:_userNameTextField.text,_passwdTextField.text, nil];
                NSLog(@"After currentUserArray is %@",currentUserArray);
                
                [defaults setObject:currentUserArray forKey:userArrayKey];
                [defaults setInteger:_lastTag+1 forKey:@"lastTagKey"];
                
                
                [defaults synchronize];
                _passwdTextField.text = [currentUserArray objectAtIndex:0];
                _passwdTextField.text = [currentUserArray objectAtIndex:1];
                _lastTag ++;

                
            }

        }
        
    }
}
@end
