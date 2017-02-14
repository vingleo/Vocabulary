//
//  VingVBLoginViewController.m
//  Vocabulary
//
//  Created by vingleo on 17/1/25.
//  Copyright © 2017年 Vingleo. All rights reserved.
//

#import "VingVBLoginViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "VingVBHomePageViewController.h"

@interface VingVBLoginViewController  () <UITextFieldDelegate>

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


-(void)didChangeValueForKey:(NSString *)key{
    if (_signSegment.selectedSegmentIndex==0) {
        _signInButton.hidden = false;
        _signUpButton.hidden = true;
        
    } else {
        _signInButton.hidden = false;
        _signUpButton.hidden = true;
        
    }

}

//Segment delegate methods
-(void)segmentAction:(UISegmentedControl *)mySeg{
    if (mySeg.selectedSegmentIndex==0) {
        _signInButton.hidden = true;
        _signUpButton.hidden = false;
        
    } else {
        _signInButton.hidden = false;
        _signUpButton.hidden = true;
        
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Default show Sign in
    _signSegment.selectedSegmentIndex=1;
        _signInButton.hidden = false;
        _signUpButton.hidden = true;
        
    
    //Add segement delegate methods Action
    [_signSegment addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    
    
    
    _userNameTextField.delegate = self;
    _passwdTextField.delegate = self;
    
    //Retrive all users
    _allUsersArray = [[NSMutableArray alloc]init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *username = [defaults stringForKey:@"registerUserNameKey"];
//    NSString *passWord = [defaults stringForKey:@"passWordKey"];
    _lastTag = [defaults integerForKey:@"lastTagKey"];
    NSLog(@"ViewDidLoad lastTag is %ld",(long)_lastTag);
    NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%ld",(long)_lastTag];
    NSArray *currentUserArray = [defaults objectForKey:userArrayKey];
    
    NSString *username = [currentUserArray objectAtIndex:0];
    NSString *passWord = [currentUserArray objectAtIndex:1];
    
    if(_lastTag) {
       // _userNameTextField.text = username;
       // _passwdTextField.text = passWord;
        
        //Get all users
        for (NSInteger i = 1; i<= _lastTag; i++) {
            NSLog(@"This is User%ld",(long)i);
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            
            NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%ld",(long)i];
            NSArray *currentUserArray = [defaults objectForKey:userArrayKey];
            NSString *currentUser = [currentUserArray objectAtIndex:0];
            [_allUsersArray addObject:currentUser];
            NSLog(@"View did Load all Users is : %@",_allUsersArray);

        }


    } else {
        _userNameTextField.text = @"";
        _passwdTextField.text = @"";
        _lastTag = 1;
    }

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

#pragma mark-- Sign in & Sign up Button function
- (IBAction)registerBtnFuc:(id)sender {
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%ld",(long)_currentTag];
    //NSArray *currentUserArray = [defaults objectForKey:userArrayKey];
    
                                 
    //NSString *currentUser = [currentUserArray objectAtIndex:0];
    //NSString *currentPasswd = [currentUserArray objectAtIndex:1];
    
    //NSLog(@"***********This is currentUser:%@",currentUser);
    
    
    //判断用户名为空——逻辑1
    if (_userNameTextField.text.length == 0) //([_passwdTextField.text isEqualToString:@""]) )
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
        //判断密码为空——逻辑2
        NSRange _range =  [_passwdTextField.text rangeOfString:@" "];
        if ((_passwdTextField.text.length == 0 ) ||(_range.location != NSNotFound)){
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
            //判断是否和现有用户重复 逻辑3
            //Retrive all users
            _allUsersArray = [[NSMutableArray alloc]init];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            //    NSString *username = [defaults stringForKey:@"registerUserNameKey"];
            //    NSString *passWord = [defaults stringForKey:@"passWordKey"];
            _lastTag = [defaults integerForKey:@"lastTagKey"];
            //NSLog(@"ViewDidLoad lastTag is %ld",(long)_lastTag);
            //NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%ld",(long)_lastTag];
            //NSArray *currentUserArray = [defaults objectForKey:userArrayKey];
            
            //NSString *username = [currentUserArray objectAtIndex:0];
            //NSString *passWord = [currentUserArray objectAtIndex:1];
            
            //判断是否存在UserDefaults文件
            //存在UserDefaults文件
            if(_lastTag) {
                //_userNameTextField.text = username;
                //_passwdTextField.text = passWord;
                
                //Get all users
                for (NSInteger i = 1; i<= _lastTag; i++) {
                    NSLog(@"This is User%ld",(long)i);
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    
                    
                    NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%ld",(long)i];
                    NSArray *currentUserArray = [defaults objectForKey:userArrayKey];
                    NSString *currentUser = [currentUserArray objectAtIndex:0];
                    [_allUsersArray addObject:currentUser];
                    NSLog(@"View did Load all Users is : %@",_allUsersArray);
                }
            }
            
            
            
            //判断是否存在UserDefaults文件
            if (_lastTag) {

                //判断是否在现有用户列表array中
                    if([_allUsersArray containsObject:_userNameTextField.text])
                    {
                        NSLog(@"存在已有用户");
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
                    //不存在已有用户
                    else{
                        NSLog(@"不存在已有用户");
                        _lastTag ++;
                        NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%ld",(long)_lastTag];
                        NSArray *currentUserArray = [NSArray arrayWithObjects:_userNameTextField.text,_passwdTextField.text, nil];
                        //NSLog(@"After currentUserArray is %@",currentUserArray);
                        
                        [defaults setObject:currentUserArray forKey:userArrayKey];
                        [defaults setInteger:_lastTag forKey:@"lastTagKey"];
                        [_allUsersArray  addObject:_userNameTextField.text];
                        [defaults synchronize];
                        NSLog(@"Add User Successful.");
                        
                        //Pop up add user successful message
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Congratulations!" message:@"Register User Success." preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                        [alert addAction:OKAction];
                        [self presentViewController:alert animated:YES completion:nil];
                        
                        
                        
                        //Clear user message box ;
                        //                    _userNameTextField.text = [currentUserArray objectAtIndex:0];
                        //                    _passwdTextField.text = [currentUserArray objectAtIndex:1];
                        _userNameTextField.text = @"";
                        _passwdTextField.text = @"";
                    }
                }
            
            //不存在UserDefaults文件
            //UserDefaults file doesn't exist.
            else {
                //设lastTag
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                _lastTag = [defaults integerForKey:@"lastTagKey"];
                _lastTag = 1;
                //NSLog(@"After lastTag is %ld",_lastTag);
                
                NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%ld",(long)_lastTag];
                
                NSArray *currentUserArray = [NSArray arrayWithObjects:_userNameTextField.text,_passwdTextField.text, nil];
                NSLog(@"After currentUserArray is %@",currentUserArray);
                
                [defaults setObject:currentUserArray forKey:userArrayKey];
                [defaults setInteger:_lastTag forKey:@"lastTagKey"];
                
                
                [defaults synchronize];
                _userNameTextField.text = [currentUserArray objectAtIndex:0];
                _passwdTextField.text = [currentUserArray objectAtIndex:1];
                //_lastTag ++;
                
                //Pop up add user successful message
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Congratulations!" message:@"Register User Success." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:OKAction];
                [self presentViewController:alert animated:YES completion:nil];
                
                
            }

        }
        
    }
}

- (IBAction)loginBtnFuc:(id)sender {
    //判断用户名为空——逻辑1
    if (_userNameTextField.text.length == 0) //([_passwdTextField.text isEqualToString:@""]) )
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
        //判断密码为空——逻辑2
        if (_passwdTextField.text.length == 0) {
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
            //判断是否具有该用户 逻辑3
            //Retrive all users
            _allUsersArray = [[NSMutableArray alloc]init];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            //    NSString *username = [defaults stringForKey:@"registerUserNameKey"];
            //    NSString *passWord = [defaults stringForKey:@"passWordKey"];
            _lastTag = [defaults integerForKey:@"lastTagKey"];
            //NSLog(@"ViewDidLoad lastTag is %ld",(long)_lastTag);
            //NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%ld",(long)_lastTag];
            //NSArray *currentUserArray = [defaults objectForKey:userArrayKey];
            
            //NSString *username = [currentUserArray objectAtIndex:0];
            //NSString *passWord = [currentUserArray objectAtIndex:1];
            
            //判断是否存在NSUserDefaults文件，存在则获取所有用户
            if(_lastTag) {
                //_userNameTextField.text = username;
                //_passwdTextField.text = passWord;
                
                //Get all users
                for (NSInteger i = 1; i<= _lastTag; i++) {
                    NSLog(@"This is User%ld",(long)i);
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    
                    
                    NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%ld",(long)i];
                    NSArray *currentUserArray = [defaults objectForKey:userArrayKey];
                    NSString *currentUser = [currentUserArray objectAtIndex:0];
                    _currentPassWd= [currentUserArray objectAtIndex:1];
                    [_allUsersArray addObject:currentUser];
                    NSLog(@"View did Load all Users is : %@",_allUsersArray);
                    
                }
            }
            
            
            
            
            
            //判断是否存在NSUserDefaults文件,存在则比对用户是否存在
            if (_lastTag) {
                
                //NSArray *array = [defaults objectForKey:userArrayKey];
                //NSString *user = [array objectAtIndex:0];
                //NSLog(@"Inside loop user is %@",user);
                //NSMutableArray *allUsersArray=[[NSMutableArray alloc]init];
                
                //[allUsersArray addObject:user];
                //NSLog(@"Inside loop allUsersArray is %@",allUsersArray);
                
                //if([allUsersArray containsObject:_userNameTextField.text])
                
                //Check allUserArray include userNameField.text
                //NSLog(@"判断是否和现有用户重复 BOOL 3. allUserArray is:%@",_allUsersArray);
                
                //判断是否在现有用户列表array中
                if([_allUsersArray containsObject:_userNameTextField.text])
                {
                    //check password match
                    if ([_passwdTextField.text isEqualToString:_currentPassWd]) {
                        //password correct
                        NSLog(@"%@ 账号密码正确",_userNameTextField.text);
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Welcome!" message:@"Sign in Success." preferredStyle:UIAlertControllerStyleAlert];
                        //alernate messge and title color
                        //                    NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:@"Warning"];
                        //                    [alertTitleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, 7)];
                        //                    [alertTitleStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 7)];
                        //                    [alert setValue:alertTitleStr forKey:@"attributedTitle"];
                        
                        //                    NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:@"Press OK sign in"];
                        //                    [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0,16)];
                        //                    [alertMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 16)];
                        //                    [alert setValue:alertMessageStr forKey:@"attributedMessage"];
                        
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            [self performSegueWithIdentifier:@"signInBack2HomePage" sender:self];
                            
                        //将当前帐号写入NSDefault
                            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                            [defaults setObject:_userNameTextField.text forKey:@"currentUserKey"];
                            
                        }];
                        [alert addAction:okAction];
                        [self presentViewController:alert animated:YES completion:nil];

                        
                        
                        
                        
                        
                        
                    } else {
                        //passwrd isn't  correct ,Alert
                        NSLog(@"%@ 账号密码不正确",_userNameTextField.text);
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error!" message:@"Password doesn't match,please try again." preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                        [alert addAction:okAction];
                        [self presentViewController:alert animated:YES completion:nil];
                        _passwdTextField.text = @"";
                        
                          }

                    
                    
                    
                    
                }
                //不存在已有用户
                else{
                    NSLog(@"不存在已有用户:%@",_userNameTextField.text);
                    //_lastTag ++;
                    //NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%ld",(long)_lastTag];
                    //NSArray *currentUserArray = [NSArray arrayWithObjects:_userNameTextField.text,_passwdTextField.text, nil];
                    //NSLog(@"After currentUserArray is %@",currentUserArray);
                    
                    //[defaults setObject:currentUserArray forKey:userArrayKey];
                    //[defaults setInteger:_lastTag forKey:@"lastTagKey"];
                    //[_allUsersArray  addObject:_userNameTextField.text];
                    //[defaults synchronize];
                    //NSLog(@"无法找到该用户");
                    
                    //Pop up add user successful message
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"用户不存在!" message:@"Please Register A User Account." preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:OKAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                    
                    
                    //Clear user message box ;
                    //                    _userNameTextField.text = [currentUserArray objectAtIndex:0];
                    //                    _passwdTextField.text = [currentUserArray objectAtIndex:1];
                    _passwdTextField.text = @"";

                    
                    
                    
                }
                
            }
            
            //NSUserDefaults file doesn't exist.
            else {
                //设lastTag
                //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                //_lastTag = [defaults integerForKey:@"lastTagKey"];
                //_lastTag = 1;
                //NSLog(@"After lastTag is %ld",_lastTag);
                
                //NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%ld",(long)_lastTag];
                
                //NSArray *currentUserArray = [NSArray arrayWithObjects:_userNameTextField.text,_passwdTextField.text, nil];
                NSLog(@"NSUserDefaults file doesn't exist");
                
                //[defaults setObject:currentUserArray forKey:userArrayKey];
                //[defaults setInteger:_lastTag forKey:@"lastTagKey"];
                
                
                //[defaults synchronize];
                //_passwdTextField.text = [currentUserArray objectAtIndex:0];
                //_passwdTextField.text = [currentUserArray objectAtIndex:1];
                //_lastTag ++;
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"User doesn't exist!" message:@"Please Register A User Account." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:OKAction];
                [self presentViewController:alert animated:YES completion:nil];

                
            }
            
            
            
            
        }
        
    }
    
    
    
  

    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"signInBack2HomePage"]) {
        VingVBHomePageViewController  *homeView = [segue destinationViewController];
        
        //Get currentUserName
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSString  *userArrayKey = [NSString stringWithFormat:@"userArrayKey%ld",(long)_lastTag];
//        NSArray *currentUserArray = [defaults objectForKey:userArrayKey];
//        
//        NSString *username = [NSString stringWithFormat:@"%@,Wecome!", [currentUserArray objectAtIndex:0]];
//        
//        homeView.currentUsername = username;
        
        homeView.currentUsername = _userNameTextField.text;
        
    }
    
    
    
}





#pragma mark-- Dismiss Text Filed
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (![touch.view isKindOfClass:[UITextField class]]||[touch.view isKindOfClass:[UITextView class]]) {
        [self.view endEditing:YES];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return  YES;
}


@end
