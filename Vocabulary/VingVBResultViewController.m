//
//  VingVBResultViewController.m
//  Vocabulary
//
//  Created by vingleo on 16/10/27.
//  Copyright © 2016年 Vingleo. All rights reserved.
//

#import "VingVBResultViewController.h"
#import "VingVBQuizViewController.h"

@interface VingVBResultViewController ()

@end

@implementation VingVBResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *correctAnswer = _detailModal[0];
    NSString *userChoose = _detailModal[1];
    
    if ([correctAnswer isEqualToString:userChoose]) {
        NSLog(@"正确!");
    _resultLabel.text = @"Correct!";
        
        
        
    }
    else {
        NSLog(@"错误!");
    _resultLabel.text = @"Wrong";
    _resultLabel.textColor = [UIColor redColor];
    }
    
    self.topTableView.dataSource = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)navigationShouldPopOnBackButton {
////    if (要弹出提示) {
////        // 在这里创建UIAlertController等方法
////        
////        return NO;
////    }
////    return YES;
//}



- (IBAction)forwardClick:(id)sender {
    
//        if (_index == [_allModal indexOfObject:[_allModal lastObject]]) {
//            NSLog(@"已经是完整内容最后一个！！");
//        }
//        else {
//            _index++;
//            _forwardModal = [_allModal objectAtIndex:_index];
//            
//            NSString *categoryText = [[_forwardModal valueForKey:@"Category"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            //NSLog(@"The current Category Text is: %@",categoryText);
//            
//            NSString *nameEnText = [[_forwardModal valueForKey:@"NameEn"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            //NSLog(@"nameEnText is: %@",nameEnText);
//            
//            NSString *nameCnText = [[_forwardModal valueForKey:@"NameZh"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            
//            
//            NSString *priceText = [[_forwardModal valueForKey:@"Price"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            //NSLog(@"price is : %@",priceText);
//            
//            NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"PaintImg" ofType:@"bundle"];
//            
//            NSString *path = [_forwardModal valueForKey:@"ImageFullPath"];
//            //NSLog(@"Image fule path is: %@",path);
//            NSString *trimmedPath = [path stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            //NSLog(@"trimmedPath is : %@",trimmedPath);
//            
//            NSString *filePath = [bundlePath stringByAppendingPathComponent:trimmedPath];
//            NSString *trimmedString = [filePath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            NSString *string1 = [trimmedString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//            NSString *imagePathText = string1;
//            //NSLog(@"imagePathText is : %@",imagePathText);
//            
//            _currentModal = @[categoryText, imagePathText,nameEnText,nameCnText,priceText];
//            //NSLog(@"preModel is %@",self.forwardModal);
//            
//            _categoryLabel.text = _currentModal[0];
//            _DetailImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_currentModal[1]]];
//            //NSLog(@"%@",[NSString stringWithFormat:@"%@",_currentModal[1]]);
//            _nameEnlabel.text = _currentModal[2];
//            _nameCnlabel.text = _currentModal[3];
//            _priceLabel.text = _currentModal[4];
//            self.navigationItem.title = _currentModal[2];
//        }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"backQuizSegue"]) {
        VingVBQuizViewController *quizView = [segue destinationViewController];
        
        self.index = [_detailModal[2] intValue];
        quizView.currentIndex = self.index+1;
        
    }
    
    
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //    NSInteger result = 0;
    //    NSArray *sectionArray = [mdictXMLPart objectForKey:@"Category"];
    //    result = [sectionArray count];
    //        return result;
        return  1;
    
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [self.topTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = @"1";
    cell.detailTextLabel.text = @"detail";
    
    return cell;
}

@end
