//
//  VingVBHomePageViewController.m
//  Vocabulary
//
//  Created by vingleo on 16/10/27.
//  Copyright © 2016年 Vingleo. All rights reserved.
//

#import "VingVBHomePageViewController.h"

@interface VingVBHomePageViewController ()

@end

@implementation VingVBHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_currentUsername) {
        _currentUserLabel.text = [NSString stringWithFormat:@"Welcome , %@",_currentUsername];

    } else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            _currentUsername = [defaults stringForKey:@"currentUserKey"];
        
        if (_currentUsername) {
            _currentUserLabel.text = [NSString stringWithFormat:@"Welcome , %@",_currentUsername];
        } else {
            _currentUserLabel.text = @"Welcome Guest User!";

        }
        
        
    }
    
    
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

@end
