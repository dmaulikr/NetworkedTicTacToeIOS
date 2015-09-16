//
//  GameViewController.m
//  COMP2601A4CLIENT-100892373
//
//  Created by Julian Clayton on 2015-04-01.
//  Copyright (c) 2015 Julian Clayton. All rights reserved.
//

#import "GameViewController.h"
#import "Game.h"
#import "Connector.h"

@interface GameViewController ()
{
    NSMutableArray *buttonArray;
}
@end

@implementation GameViewController
@synthesize button0, button1, button2, button3, button4, button5, button6, button7, button8, textField, startButton;


- (void)viewDidLoad {
    [super viewDidLoad];
    buttonArray = [[NSMutableArray alloc] initWithObjects:button0, button1,button2,button3,button4,button5,button6,button7,button8, nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newGameStartedByOpponent:) name:@"newGameStartedByOpponent" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameStoppedByOpponent:) name:@"gameStoppedByOpponent" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(opponentMove:) name:@"opponentMove" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameWon:) name:@"gameWon" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameQuit:) name:@"gameQuit" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button0click:(id)sender
{
    if ([[Game gameInstance] isPlaying] == true && [[Game gameInstance]isMyTurn] == true && [[[[Game gameInstance] getGameBoard]objectAtIndex:0] integerValue] == 0 ){
        [textField setText:NSLocalizedString(@"you_play_button_0", nil)];
        if ([[Game gameInstance] getXTurn] == true){
            [button0 setImage:[UIImage imageNamed:@"button_x.png"] forState:UIControlStateNormal];
            [[Game gameInstance] playerPlace:0];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        else if ([[Game gameInstance] getXTurn] == false){
            [button0 setImage:[UIImage imageNamed:@"button_o.png"] forState:UIControlStateNormal];
            [[Game gameInstance] oPlace:0];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        [[Game gameInstance] setMyTurn:false];
        if ([[Game gameInstance] getXTurn] == true){ //if this is the client
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getClientSocket] : @"0"];
        }
        else if ([[Game gameInstance] getXTurn] == false){ //if this is the server
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getServerSocket] :@"0" ];
        }
    }
    
}

- (IBAction)button1click: (id)sender
{
    if ([[Game gameInstance] isPlaying] == true && [[Game gameInstance]isMyTurn] == true && [[[[Game gameInstance] getGameBoard]objectAtIndex:1] integerValue] == 0){
        [textField setText:NSLocalizedString(@"you_play_button_1", nil)];
        if ([[Game gameInstance] getXTurn] == true){
            [button1 setImage:[UIImage imageNamed:@"button_x.png"] forState:UIControlStateNormal];
            [[Game gameInstance] playerPlace:1];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        else if ([[Game gameInstance] getXTurn] == false){
            [button1 setImage:[UIImage imageNamed:@"button_o.png"] forState:UIControlStateNormal];
            [[Game gameInstance] oPlace:1];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        [[Game gameInstance] setMyTurn:false];
        if ([[Game gameInstance] getXTurn] == true){ //if this is the client
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getClientSocket] : @"1"];
        }
        else if ([[Game gameInstance] getXTurn] == false){ //if this is the server
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getServerSocket] :@"1" ];
        }
    }
    if ([[[Game gameInstance] checkWin] integerValue] != 0){
        [self gameOver];
    }
}
- (IBAction)button2click: (id)sender
{
    if ([[Game gameInstance] isPlaying] == true && [[Game gameInstance]isMyTurn] == true && [[[[Game gameInstance] getGameBoard]objectAtIndex:2]integerValue] == 0){
        NSLog(@"BUTTON 2");
        [textField setText:NSLocalizedString(@"you_play_button_2", nil)];
        if ([[Game gameInstance] getXTurn] == true){
            [button2 setImage:[UIImage imageNamed:@"button_x.png"] forState:UIControlStateNormal];
            [[Game gameInstance] playerPlace:2];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        else if ([[Game gameInstance] getXTurn] == false){
            [button2 setImage:[UIImage imageNamed:@"button_o.png"] forState:UIControlStateNormal];
            [[Game gameInstance] oPlace:2];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        [[Game gameInstance] setMyTurn:false];
        if ([[Game gameInstance] getXTurn] == true){ //if this is the client
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getClientSocket] : @"2"];
        }
        else if ([[Game gameInstance] getXTurn] == false){ //if this is the server
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getServerSocket] :@"2" ];
        }
    }
    if ([[[Game gameInstance] checkWin] integerValue] != 0){
        [self gameOver];
    }
}
- (IBAction)button3click: (id)sender
{
    if ([[Game gameInstance] isPlaying] == true && [[Game gameInstance]isMyTurn] == true && [[[[Game gameInstance] getGameBoard]objectAtIndex:3]integerValue] == 0){
        [textField setText:NSLocalizedString(@"you_play_button_3", nil)];
        NSLog(@"BUTTON 3");
        if ([[Game gameInstance] getXTurn] == true){
            [button3 setImage:[UIImage imageNamed:@"button_x.png"] forState:UIControlStateNormal];
            [[Game gameInstance] playerPlace:3];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        else if ([[Game gameInstance] getXTurn] == false){
            [button3 setImage:[UIImage imageNamed:@"button_o.png"] forState:UIControlStateNormal];
            [[Game gameInstance] oPlace:3];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        [[Game gameInstance] setMyTurn:false];
        if ([[Game gameInstance] getXTurn] == true){ //if this is the client
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getClientSocket] : @"3"];
        }
        else if ([[Game gameInstance] getXTurn] == false){ //if this is the server
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getServerSocket] :@"3" ];
        }
    }
    if ([[[Game gameInstance] checkWin] integerValue] != 0){
        [self gameOver];
    }
}
- (IBAction)button4click: (id)sender
{
    if ([[Game gameInstance] isPlaying] == true && [[Game gameInstance]isMyTurn] == true && [[[[Game gameInstance] getGameBoard]objectAtIndex:4] integerValue] == 0){
        NSLog(@"BUTTON 4");
        [textField setText:NSLocalizedString(@"you_play_button_4", nil)];
        if ([[Game gameInstance] getXTurn] == true){
            [button4 setImage:[UIImage imageNamed:@"button_x.png"] forState:UIControlStateNormal];
            [[Game gameInstance] playerPlace:4];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        else if ([[Game gameInstance] getXTurn] == false){
            [button4 setImage:[UIImage imageNamed:@"button_o.png"] forState:UIControlStateNormal];
            [[Game gameInstance] oPlace:4];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        [[Game gameInstance] setMyTurn:false];
        
        if ([[Game gameInstance] getXTurn] == true){ //if this is the client
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getClientSocket] : @"4"];
        }
        else if ([[Game gameInstance] getXTurn] == false){ //if this is the server
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getServerSocket] :@"4" ];
        }
    }
    if ([[[Game gameInstance] checkWin] integerValue] != 0){
        [self gameOver];
    }
}
- (IBAction)button5click: (id)sender
{
    if ([[Game gameInstance] isPlaying] == true && [[Game gameInstance]isMyTurn] == true && [[[[Game gameInstance] getGameBoard]objectAtIndex:5] integerValue] == 0){
        [textField setText:NSLocalizedString(@"you_play_button_5", nil)];
        NSLog(@"BUTTON 5");
        if ([[Game gameInstance] getXTurn] == true){
            [button5 setImage:[UIImage imageNamed:@"button_x.png"] forState:UIControlStateNormal];
            [[Game gameInstance] playerPlace:5];
            
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        else if ([[Game gameInstance] getXTurn] == false){
            [button5 setImage:[UIImage imageNamed:@"button_o.png"] forState:UIControlStateNormal];
            [[Game gameInstance] oPlace:5];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        [[Game gameInstance] setMyTurn:false];
        
        if ([[Game gameInstance] getXTurn] == true){ //if this is the client
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getClientSocket] : @"5"];
        }
        else if ([[Game gameInstance] getXTurn] == false){ //if this is the server
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getServerSocket] :@"5" ];
        }
    }
    if ([[[Game gameInstance] checkWin] integerValue] != 0){
        [self gameOver];
    }
}
- (IBAction)button6click: (id)sender
{
    if ([[Game gameInstance] isPlaying] == true && [[Game gameInstance]isMyTurn] == true && [[[[Game gameInstance] getGameBoard]objectAtIndex:6]integerValue] == 0){
        [textField setText:NSLocalizedString(@"you_play_button_6", nil)];
        NSLog(@"BUTTON 6");
        if ([[Game gameInstance] getXTurn] == true){
            [button6 setImage:[UIImage imageNamed:@"button_x.png"] forState:UIControlStateNormal];
            [[Game gameInstance] playerPlace:6];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        else if ([[Game gameInstance] getXTurn] == false){
            [button6 setImage:[UIImage imageNamed:@"button_o.png"] forState:UIControlStateNormal];
            [[Game gameInstance] oPlace:6];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        [[Game gameInstance] setMyTurn:false];
        
        if ([[Game gameInstance] getXTurn] == true){ //if this is the client
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getClientSocket] : @"6"];
        }
        else if ([[Game gameInstance] getXTurn] == false){ //if this is the server
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getServerSocket] :@"6" ];
        }
    }
    if ([[[Game gameInstance] checkWin] integerValue] != 0){
        [self gameOver];
    }
}
- (IBAction)button7click: (id)sender
{
    if ([[Game gameInstance] isPlaying] == true && [[Game gameInstance]isMyTurn] == true && [[[[Game gameInstance] getGameBoard]objectAtIndex:7] integerValue] == 0){
        [textField setText:NSLocalizedString(@"you_play_button_7", nil)];
        NSLog(@"BUTTON 7");
        if ([[Game gameInstance] getXTurn] == true){
            [button7 setImage:[UIImage imageNamed:@"button_x.png"] forState:UIControlStateNormal];
            [[Game gameInstance] playerPlace:7];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        else if ([[Game gameInstance] getXTurn] == false){
            [button7 setImage:[UIImage imageNamed:@"button_o.png"] forState:UIControlStateNormal];
            [[Game gameInstance] oPlace:7];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        [[Game gameInstance] setMyTurn:false];
        if ([[Game gameInstance] getXTurn] == true){ //if this is the client
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getClientSocket] : @"7"];
        }
        else if ([[Game gameInstance] getXTurn] == false){ //if this is the server
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getServerSocket] :@"7" ];
        }
    }
    if ([[[Game gameInstance] checkWin] integerValue] != 0){
        [self gameOver];
    }
}
- (IBAction)button8click:(id)sender
{
    if ([[Game gameInstance] isPlaying] == true && [[Game gameInstance]isMyTurn] == true && [[[[Game gameInstance] getGameBoard]objectAtIndex:8] integerValue] == 0){
        [textField setText:NSLocalizedString(@"you_play_button_8", nil)];
        NSLog(@"BUTTON 8");
        if ([[Game gameInstance] getXTurn] == true){
            [button8 setImage:[UIImage imageNamed:@"button_x.png"] forState:UIControlStateNormal];
            [[Game gameInstance] xPlace:8];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        else if ([[Game gameInstance] getXTurn] == false){
            [button8 setImage:[UIImage imageNamed:@"button_o.png"] forState:UIControlStateNormal];
            [[Game gameInstance] oPlace:8];
            if ([[[Game gameInstance] checkWin] integerValue] != 0){
                [self gameOver];
            }
        }
        [[Game gameInstance] setMyTurn:false];
        if ([[Game gameInstance] getXTurn] == true){ //if this is the client
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getClientSocket] : @"8"];
        }
        else if ([[Game gameInstance] getXTurn] == false){ //if this is the server
            [[Connector connectorInstance] sendMoveMessage:[[Connector connectorInstance] getServerSocket] :@"8" ];
        }
    }
    if ([[[Game gameInstance] checkWin] integerValue] != 0){
        [self gameOver];
    }
}
- (IBAction)startButtonClick:(id)sender {
    if ([[Game gameInstance] isPlaying] == false){// if a game is currently not being played
        [[Game gameInstance] newGame];
        [textField setText:NSLocalizedString(@"game_started", nil)];
        [startButton setTitle:NSLocalizedString(@"stop", nil) forState:UIControlStateNormal];
        //clear the board GUI
        for (int i = 0; i < [buttonArray count]; i++){
            [buttonArray[i] setImage:[UIImage imageNamed:@"button_empty.png"] forState:UIControlStateNormal];
        }
        //Send gameOn message to the other player
        if ([[Game gameInstance] getXTurn] == true){ //if this is the client//RIGGHT
            [[Connector connectorInstance] sendGameOn:[[Connector connectorInstance] getClientSocket]];
        }
        else if ([[Game gameInstance] getXTurn] == false){ //if this is the server
            [[Connector connectorInstance] sendGameOn:[[Connector connectorInstance] getServerSocket]];
        }
    }///THESE ARE
    else if ([[Game gameInstance] isPlaying] == true){
        [[Game gameInstance] endGame];
         [textField setText:NSLocalizedString(@"game_stopped", nil)];
        [startButton setTitle:NSLocalizedString(@"start", nil)forState:UIControlStateNormal];
        if ([[Game gameInstance] getXTurn] == true){ //if this is the client//RIGHT
            [[Connector connectorInstance] sendGameOver:[[Connector connectorInstance] getClientSocket] :@"gameEnded"];
        }
        else if ([[Game gameInstance] getXTurn] == false){ //if this is the server
            [[Connector connectorInstance] sendGameOver:[[Connector connectorInstance] getServerSocket] :@"gameEnded"];
        }
    }
}


//Just clears the GUI if a new game has been started
- (void) newGameStartedByOpponent: (NSNotification*) notification
{
    NSLog(@"NSNotification game started");
    for (int i = 0; i < [buttonArray count]; i++){
        [buttonArray[i] setImage:[UIImage imageNamed:@"button_empty.png"] forState:UIControlStateNormal];
    }
    [startButton setTitle:@"Stop" forState:UIControlStateNormal];
    [textField setText:@"Game Started by opponent"];
}

- (void) gameStoppedByOpponent: (NSNotification*) notification
{
    [startButton setTitle:NSLocalizedString(@"start", nil)forState:UIControlStateNormal];
    [textField setText:@"Game Stopped by opponent"]; 
    NSLog(@"NSNotification game stopped");
}
- (void) opponentMove: (NSNotification*) notification
{
    NSString* tile = [notification object];
    NSInteger* tileNumber = [tile integerValue];
    NSString* d = [NSString stringWithFormat:NSLocalizedString(@"opponent_plays", nil), (int)tileNumber];
    [textField setText:d];
    if ([[Game gameInstance] getXTurn] == true){
        [[Game gameInstance] oPlace:(int)tileNumber];
        [buttonArray[(int)tileNumber] setImage:[UIImage imageNamed:@"button_o.png"] forState:UIControlStateNormal];
        if ([[[Game gameInstance] checkWin] integerValue] != 0){
            [self gameOver];
        }
    }
    if ([[Game gameInstance] getXTurn] == false){
        [[Game gameInstance] xPlace:(int)tileNumber];
        [buttonArray[(int)tileNumber] setImage:[UIImage imageNamed:@"button_x.png"] forState:UIControlStateNormal];
        if ([[[Game gameInstance] checkWin] integerValue] != 0){
            [self gameOver];
        }
    }
    if ([[[Game gameInstance] checkWin] integerValue] != 0){
        [self gameOver];
    }
}
- (void) gameOver
{
    [startButton setTitle:NSLocalizedString(@"start", nil) forState:UIControlStateNormal];
    
    [[Game gameInstance] printGame];
    if ([[[Game gameInstance] checkWin] integerValue] == 1){
        [textField setText:NSLocalizedString(@"x_wins", nil)];
    }
    if ([[[Game gameInstance] checkWin]integerValue] == -1){
            [textField setText:@"O Wins!"];
    }
    if ([[[Game gameInstance] checkWin] integerValue] == 2){
        [textField setText:@"Draw"];
    }
    if ([[Game gameInstance] getXTurn] == true){ //if this is the client//RIGHT
        [[Connector connectorInstance] sendGameWon:[[Connector connectorInstance] getClientSocket]];
    }
    if ([[Game gameInstance] getXTurn] == false){ //if this is the server
        [[Connector connectorInstance] sendGameWon:[[Connector connectorInstance] getServerSocket]];
    }
    [[Game gameInstance] endGame];
}
- (void) gameWon: (NSNotification *) notification
{
    [[Game gameInstance] printGame];
    [startButton setTitle:NSLocalizedString(@"start", nil) forState:UIControlStateNormal];
    if ([[[Game gameInstance] checkWin] integerValue] == 1){
        [textField setText:NSLocalizedString(@"x_wins", nil)];
    }
    if ([[[Game gameInstance] checkWin]integerValue] == -1){
            [textField setText:@"O Wins!"];

    }
    if ([[[Game gameInstance] checkWin] integerValue] == 2){
        [textField setText:NSLocalizedString(@"draw", nil)];
    }
    [[Game gameInstance] endGame];
}
- (IBAction)quitButtonClick:(id)sender
{
    [self performSegueWithIdentifier:@"SEGUE_IDENTIFIER_BACK" sender:self];
    if ([[Game gameInstance] getXTurn] == true){ //if this is the client//RIGHT
        [[Connector connectorInstance] sendGameQuit:[[Connector connectorInstance] getClientSocket]];
    }
    if ([[Game gameInstance] getXTurn] == false){ //if this is the server
        [[Connector connectorInstance] sendGameQuit:[[Connector connectorInstance] getServerSocket]];
    }
    [[[Connector connectorInstance] getClientSocket] disconnect];
    [[[Connector connectorInstance] getServerSocket] disconnect];
}
- (void) gameQuit: (NSNotification *) notification
{
    [self performSegueWithIdentifier:@"SEGUE_IDENTIFIER_BACK" sender:self];
    
    [[[Connector connectorInstance] getClientSocket] disconnect];
    [[[Connector connectorInstance] getServerSocket] disconnect];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SEGUE_IDENTIFIER_BACK"]) {
        ViewController *viewController = (ViewController *)segue.destinationViewController;
    }
}
@end
