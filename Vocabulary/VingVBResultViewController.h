//
//  VingVBResultViewController.h
//  Vocabulary
//
//  Created by vingleo on 16/10/27.
//  Copyright © 2016年 Vingleo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VingVBResultViewController : UIViewController<UITableViewDataSource>

@property(strong,nonatomic)  NSIndexPath *lastIndexPath;
@property NSUInteger index;

@property (strong,nonatomic) NSArray *detailModal;
@property (strong,nonatomic) NSArray *allModal;
@property (strong,nonatomic) NSArray *currentModal;
@property (strong,nonatomic) NSArray *preModal;
@property (strong,nonatomic) NSArray *forwardModal;
@property (strong,nonatomic) NSArray *searchResultModal;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UITableView *topTableView;

- (IBAction)forwardClick:(id)sender;


@end
