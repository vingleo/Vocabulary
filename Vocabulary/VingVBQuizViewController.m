//
//  VingVBQuizViewController.m
//  Vocabulary
//
//  Created by vingleo on 16/10/27.
//  Copyright © 2016年 Vingleo. All rights reserved.
//  Create Git function by Vingleo 2017.01.22
//  Add change question function 2017.01.26
//  Add User status saving funciton by Vingleo 2017.02.03

#import "VingVBQuizViewController.h"
#import "VingVBResultViewController.h"

@interface VingVBQuizViewController ()

@end

@implementation VingVBQuizViewController
@synthesize dictData,marrXMLData,mstrXMLString,mdictXMLPart;



-(void)startParsing {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"vocaXML" ofType:@"xml"];
    NSXMLParser *xmlParser = [[NSXMLParser alloc]initWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    [xmlParser setDelegate:self];
    [xmlParser parse];
    
//    if (marrXMLData.count != 0) {
//        [self.tableView reloadData];
//    }
    
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    if ([elementName isEqualToString:@"Root"]) {
        marrXMLData = [[NSMutableArray alloc]init];
    }
    if ([elementName isEqualToString:@"Row"]) {
        mdictXMLPart = [[NSMutableDictionary alloc]init];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!mstrXMLString) {
        mstrXMLString  = [[NSMutableString alloc]initWithString:string];
    }
    else {
        [mstrXMLString appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{

    if ([elementName isEqualToString:@"questionNumber"]||[elementName isEqualToString:@"questionIndexKey"]||[elementName isEqualToString:@"level1Base"]||[elementName isEqualToString:@"level2Base"]||[elementName isEqualToString:@"questionType"]||[elementName isEqualToString:@"question"]||[elementName isEqualToString:@"answer1"]||[elementName isEqualToString:@"answer2"]||[elementName isEqualToString:@"answer3"]||[elementName isEqualToString:@"correctAnswer"]||[elementName isEqualToString:@"testWord"]||[elementName isEqualToString:@"hint"]||[elementName isEqualToString:@"audio"])
    {
        [mdictXMLPart setObject:mstrXMLString forKey:elementName];
    }
    if ([elementName isEqualToString:@"Row"]) {
        [marrXMLData addObject:mdictXMLPart];
    }
    mstrXMLString = nil;
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"Error Message : %@", [parser description]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startParsing];
    
    
    NSLog(@"mdictXMLPart count is %lu",(unsigned long)[mdictXMLPart count]);

    NSLog(@"marrXMLData array count is:%lu",(unsigned long)[marrXMLData count]);
    NSLog(@"marrXMLData array is %@",marrXMLData);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
//    NSString *c_questionNumber = [defaults stringForKey:@"questionNumberKey"];
//    NSString *c_questionIndexKeyText = [defaults stringForKey:@"questionIndexKeyTextKey"];
//    NSString *c_level1BaseText = [defaults stringForKey:@"level1BaseTextKey"];
//    NSString *c_level2BaseText = [defaults stringForKey:@"level2BaseTextKey"];
//    NSString *c_questionTypeText = [defaults stringForKey:@"questionTypeTextKey"];
//    NSString *c_questionText = [defaults stringForKey:@"questionTextKey"];
//    NSString *c_answer1Text  = [defaults stringForKey:@"answer1TextKey"];
//    NSString *c_answer2Text  = [defaults stringForKey:@"answer2TextKey"];
//    NSString *c_answer3Text  = [defaults stringForKey:@"answer3TextKey"];
//    NSString *c_correctAnswerText  = [defaults stringForKey:@"correctAnswerTextKey"];
//    NSString *c_testWordText  = [defaults stringForKey:@"testWordTextKey"];
//    NSString *c_hintText  = [defaults stringForKey:@"hintTextKey"];
//    NSString *c_audioText  = [defaults stringForKey:@"audioTextKey"];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"currentIndexNumberKey"]==nil)
    {
        NSLog(@"hasRunBefore is false");
        self.level1BaseLabel.text = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"level1Base"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //    NSLog(@"level1BaseLabel text is : %@",self.level1BaseLabel);
        self.level2BaseLabel.text = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"level2Base"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //    NSLog(@"level1BaseLabe2 text is : %@",self.level2BaseLabel);
        self.questionTypeLabel.text = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"questionType"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //    NSLog(@"questionTypeLabel text is : %@",self.questionTypeLabel);
        self.questionLabel.text = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"question"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //    NSLog(@"questionLabel text is : %@", self.questionLabel);
        
        
        [_answer1Button setTitle:[[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"answer1"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forState:UIControlStateNormal];
        //    NSLog(@"answer 1 is %@",self.answer1Button.titleLabel.text);
        [_answer2Button setTitle:[[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"answer2"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forState:UIControlStateNormal];
        [_answer3Button setTitle:[[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"answer3"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forState:UIControlStateNormal];
        
        _questionNumLbl.text = [NSString stringWithFormat:@"Question #%lu",_currentIndex+1];
        
        //_currentIndex = [_questionNumber intValue];
        NSLog(@"currentIndex  is  %lu",(unsigned long)_currentIndex);

    } else {
        if (!_currentIndex) {
            _currentIndex = [defaults integerForKey:@"currentIndexNumberKey"];
            
            
            self.level1BaseLabel.text = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"level1Base"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            //    NSLog(@"level1BaseLabel text is : %@",self.level1BaseLabel);
            self.level2BaseLabel.text = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"level2Base"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            //    NSLog(@"level1BaseLabe2 text is : %@",self.level2BaseLabel);
            self.questionTypeLabel.text = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"questionType"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            //    NSLog(@"questionTypeLabel text is : %@",self.questionTypeLabel);
            self.questionLabel.text = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"question"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            //    NSLog(@"questionLabel text is : %@", self.questionLabel);
            
            
            [_answer1Button setTitle:[[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"answer1"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forState:UIControlStateNormal];
            //    NSLog(@"answer 1 is %@",self.answer1Button.titleLabel.text);
            [_answer2Button setTitle:[[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"answer2"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forState:UIControlStateNormal];
            [_answer3Button setTitle:[[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"answer3"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forState:UIControlStateNormal];
            
            _questionNumLbl.text = [NSString stringWithFormat:@"Question #%lu",_currentIndex+1];
            
            //_currentIndex = [_questionNumber intValue];
            NSLog(@"currentIndex  is  %lu",(unsigned long)_currentIndex);
        } else{
            self.level1BaseLabel.text = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"level1Base"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            //    NSLog(@"level1BaseLabel text is : %@",self.level1BaseLabel);
            self.level2BaseLabel.text = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"level2Base"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            //    NSLog(@"level1BaseLabe2 text is : %@",self.level2BaseLabel);
            self.questionTypeLabel.text = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"questionType"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            //    NSLog(@"questionTypeLabel text is : %@",self.questionTypeLabel);
            self.questionLabel.text = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"question"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            //    NSLog(@"questionLabel text is : %@", self.questionLabel);
            
            
            [_answer1Button setTitle:[[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"answer1"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forState:UIControlStateNormal];
            //    NSLog(@"answer 1 is %@",self.answer1Button.titleLabel.text);
            [_answer2Button setTitle:[[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"answer2"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forState:UIControlStateNormal];
            [_answer3Button setTitle:[[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"answer3"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forState:UIControlStateNormal];
            
            _questionNumLbl.text = [NSString stringWithFormat:@"Question #%lu",_currentIndex+1];
            
            //_currentIndex = [_questionNumber intValue];
            NSLog(@"currentIndex  is  %lu",(unsigned long)_currentIndex);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"answer1Segue"]||[[segue identifier] isEqualToString:@"answer2Segue"]||[[segue identifier] isEqualToString:@"answer3Segue"]) {
        VingVBResultViewController *resultView = [segue destinationViewController];
        
        //01_questionNumber = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"keyID"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _questionNumber = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"keyID"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //02_questionIndexKeyText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"questionIndexKey"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _questionIndexKeyText = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"questionIndexKey"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //03_level1BaseText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"level1Base"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _level1BaseText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"level1Base"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //04_level2BaseText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"level2Base"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _level2BaseText = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"level2Base"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //05_questionTypeText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"questionType"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _questionTypeText = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"questionType"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //06_questionText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"question"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _questionText = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"question"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //07_answer1Text = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"answer1"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _answer1Text = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"answer1"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //08_answer2Text = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"answer2"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _answer2Text = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"answer2"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //09_answer3Text = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"answer3"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _answer3Text = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"answer3"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //10_correctAnswerText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"correctAnswer"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _correctAnswerText = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"correctAnswer"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //11_testWordText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"testWord"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _testWordText = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"testWord"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //12_hintText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"hint"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _hintText = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"hint"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //13_audioText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"audio"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _audioText = [[[marrXMLData objectAtIndex:_currentIndex]valueForKey:@"audio"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        resultView.detailModal = @[_correctAnswerText,_userChooseText,_level1BaseText];
        resultView.currentIndex = _currentIndex;
        
        
//        resultView.detailModal = @[_keyID,_questionIndexKeyText,_level1BaseText,_level2BaseText,_questionTypeText,_questionText,_answer1Text,_answer2Text,_answer3Text,_correctAnswerText,_testWordText,_hintText,_audioText,_userChooseText];
        
    }
    
    
    
}

- (IBAction)getChooseText:(id)sender {
    UIButton *button = (UIButton *)sender;
    _userChooseText = button.titleLabel.text;
    
}

- (IBAction)getBackMainPage:(id)sender {
    //Save user current status
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Save or Leave?" message:@"Do you want save Or leave?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self performSegueWithIdentifier:@"back2main" sender:self];
        
        [defaults setInteger:_currentIndex forKey:@"currentIndexNumberKey"];
        
        [defaults synchronize];
        NSLog(@"User Status saved.");
        NSString *app_path = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
        NSLog(@"APP_Path = %@", app_path);
        
        //for get Documents folder
        /*
        NSFileManager *fileManager = [[NSFileManager alloc]init];
        NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        if ([urls count]>0) {
            NSURL *documentsFolder = urls[0];
            NSLog(@"%@",documentsFolder);
        }
        else {
            NSLog(@"Could not find the Documents folder");
        }
        
        NSString *tempDirectory = NSTemporaryDirectory();
        NSLog(@"Temp Directory = %@",tempDirectory);
        */
        //Add String to text file
        /*
        NSString *someText  = @"Random string that won't be backed up.";
        
        NSString *destinationPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"MyFile.txt"];
        
        NSError *error = nil;
        BOOL successed = [someText writeToFile:destinationPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (successed) {
            NSLog(@"Successfully stored the file at: %@",destinationPath);
        } else {
            NSLog(@"Failed to store the file. Error = %@",error);
        }
        */
        
    }];
    
    [alert addAction:saveAction];
    
    //notSaveAction
        UIAlertAction *notSaveAction = [UIAlertAction actionWithTitle:@"Leave anyway." style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self performSegueWithIdentifier:@"back2main" sender:self];
        _currentIndex = 0;
        [defaults setInteger:_currentIndex forKey:@"currentIndexNumberKey"];
            NSString *tempUsername = [defaults stringForKey:@"registerUserNameKey"];
            NSString *tempPassWord = [defaults stringForKey:@"passWordKey"];
            NSArray *userInfo = [NSArray arrayWithObjects:tempUsername,tempPassWord,_currentIndex, nil];
            [defaults setObject:userInfo forKey:@"userInfoKey"];
        
        
        
        [defaults synchronize];
        NSLog(@"User Status saved.");
        NSString *app_path = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
        NSLog(@"APP_Path = %@", app_path);
        
    }];
    
    [alert addAction:notSaveAction];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}


@end
