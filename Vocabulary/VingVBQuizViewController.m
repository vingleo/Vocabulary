//
//  VingVBQuizViewController.m
//  Vocabulary
//
//  Created by vingleo on 16/10/27.
//  Copyright © 2016年 Vingleo. All rights reserved.
//  Create Git function by Vingleo 2017.01.22
//  Add change question function

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
        
        _questionNumber = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"keyID"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _questionIndexKeyText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"questionIndexKey"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _level1BaseText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"level1Base"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _level2BaseText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"level2Base"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _questionTypeText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"questionType"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _questionText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"question"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _answer1Text = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"answer1"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _answer2Text = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"answer2"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _answer3Text = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"answer3"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _correctAnswerText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"correctAnswer"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _testWordText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"testWord"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _hintText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"hint"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _audioText = [[[marrXMLData objectAtIndex:[_questionNumber intValue]]valueForKey:@"audio"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Are you sure to leave this test?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"I'm sure." style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self performSegueWithIdentifier:@"back2main" sender:self];
    }];
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}


@end
