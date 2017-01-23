//
//  VingVBQuizViewController.h
//  Vocabulary
//
//  Created by vingleo on 16/10/27.
//  Copyright © 2016年 Vingleo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VingVBQuizViewController : UIViewController<NSXMLParserDelegate>

@property NSUInteger currentIndex;

@property(nonatomic,strong)NSMutableDictionary *dictData;
@property(nonatomic,strong)NSMutableArray *marrXMLData;
@property(nonatomic,strong)NSMutableString *mstrXMLString;
@property(nonatomic,strong)NSMutableDictionary *mdictXMLPart;

@property(nonatomic,strong)NSArray *questionType1Results;
@property(nonatomic,strong)NSArray *questionType2Results;
@property(nonatomic,strong)NSArray *questionType3Results;
@property(nonatomic,strong)NSArray *questionType4Results;
@property(nonatomic,strong)NSArray *questionType5Results;
@property(nonatomic,strong)NSArray *questionType6Results;


@property(nonatomic,strong)NSString *questionNumber;
@property(nonatomic,strong)NSString *questionIndexKeyText;
@property(nonatomic,strong)NSString *level1BaseText;
@property(nonatomic,strong)NSString *level2BaseText;
@property(nonatomic,strong)NSString *questionTypeText;
@property(nonatomic,strong)NSString *questionText;
@property(nonatomic,strong)NSString *answer1Text;
@property(nonatomic,strong)NSString *answer2Text;
@property(nonatomic,strong)NSString *answer3Text;
@property(nonatomic,strong)NSString *correctAnswerText;
@property(nonatomic,strong)NSString *testWordText;
@property(nonatomic,strong)NSString *hintText;
@property(nonatomic,strong)NSString *audioText;

@property(nonatomic,strong)NSString *userChooseText;
@property NSUInteger answerWordCorrectCount;
@property NSUInteger testWordQuestionCount;

@property (weak, nonatomic) IBOutlet UILabel *level1BaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *level2BaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (weak, nonatomic) IBOutlet UIButton *answer1Button;
@property (weak, nonatomic) IBOutlet UIButton *answer2Button;
@property (weak, nonatomic) IBOutlet UIButton *answer3Button;

- (IBAction)getChooseText:(id)sender;

//For SearchBar
/*
@property(nonatomic,strong) UISearchController *searchController;
@property(nonatomic,strong) UITableViewController *resultController;
@property(nonatomic,strong) NSMutableArray *fiterResults;
@property(nonatomic,strong) NSMutableArray *searchResults;
@property(nonatomic,strong) NSString *searchText;
*/

@end
