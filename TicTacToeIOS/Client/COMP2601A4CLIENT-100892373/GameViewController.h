//
//  GameViewController.h
//  COMP2601A4CLIENT-100892373
//
//  Created by Julian Clayton on 2015-04-01.
//  Copyright (c) 2015 Julian Clayton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *gameViewController;
@property (weak, nonatomic) IBOutlet UIButton *button0;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *quitButton;

- (IBAction)quitButtonClick:(id)sender;
- (IBAction)button0click:(id)sender;
- (IBAction)button1click:(id)sender;
- (IBAction)button2click:(id)sender;
- (IBAction)button3click:(id)sender;
- (IBAction)button4click:(id)sender;
- (IBAction)button5click:(id)sender;
- (IBAction)button6click:(id)sender;
- (IBAction)button7click:(id)sender;
- (IBAction)button8click:(id)sender;
- (IBAction)startButtonClick:(id)sender;

@end
