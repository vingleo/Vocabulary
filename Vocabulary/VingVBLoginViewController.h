//
//  VingVBLoginViewController.h
//  Vocabulary
//
//  Created by vingleo on 17/1/25.
//  Copyright © 2017年 Vingleo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>//指纹识别


@interface VingVBLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;

@property NSInteger userID;
@property NSInteger lastTag;

@property NSMutableArray *allUsersArray;
@property (weak, nonatomic) IBOutlet UISegmentedControl *signSegment;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

- (IBAction)registerBtnFuc:(id)sender;
- (IBAction)loginBtnFuc:(id)sender;

@end
