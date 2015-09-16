//
//  Game.m
//  COMP2601A3-100892373
//
//  Created by Julian Clayton on 2015-03-06.
//  Copyright (c) 2015 Julian Clayton. All rights reserved.
//

#import "Game.h"

@implementation Game

- (void) inititializeBoard
{
    gameBoard = [[NSMutableArray alloc] init];
    for (int i = 0; i < 9; i++){
        [gameBoard addObject:[NSNumber numberWithInt:0]];
    }

}
- (void) setXTurn:(Boolean)xt
{
    xTurn = xt;
}
- (Boolean) getXTurn
{
    return xTurn;
}
- (void) setMyTurn:(Boolean)mt
{
    myTurn = mt;
}
+ (Game *) gameInstance
{
    static Game *gameInstance;
    @synchronized(self)
    {
        if (!gameInstance)
            gameInstance = [[Game alloc] init];
        return gameInstance;
    }
}

- (void) newGame
{
    [self inititializeBoard];
    x = true;
    playing = true;
    [self printGame];

}

- (NSMutableArray *) getGameBoard
{
    return gameBoard;
}


- (Boolean) checkForDraw
{
    Boolean isFull = true;
    for (int i = 0; i < 9; i++){
        if ([[gameBoard objectAtIndex:i] integerValue] == 0 ){
            isFull = false;
        }
    }
    return isFull;
}


- (NSNumber *) checkWin
{
    NSNumber *winner = [NSNumber numberWithInteger:0];
    if ( [self checkForDraw] == true){
        winner = [NSNumber numberWithInteger: 2];
        playing = false;
        return winner;
    }    //HERE ARE THE COLUMNS
    if ( [[gameBoard objectAtIndex:0] integerValue] + [[gameBoard objectAtIndex:3] integerValue] + [[gameBoard objectAtIndex:6] integerValue] == 3){
        winner = [NSNumber numberWithInteger:1];
        playing = false;
    }
    //
    if ( [[gameBoard objectAtIndex:0] integerValue] + [[gameBoard objectAtIndex:3] integerValue] + [[gameBoard objectAtIndex:6] integerValue] == -3){
        winner = [NSNumber numberWithInteger:-1];
        playing = false;
    }
    //
    if ( [[gameBoard objectAtIndex:1] integerValue] + [[gameBoard objectAtIndex:4] integerValue] + [[gameBoard objectAtIndex:7] integerValue] == 3) {
        winner = [NSNumber numberWithInteger:1];
        playing = false;
    }
    if ( [[gameBoard objectAtIndex:1] integerValue] + [[gameBoard objectAtIndex:4] integerValue] + [[gameBoard objectAtIndex:7] integerValue] == -3) {
        winner = [NSNumber numberWithInteger:-1];
        playing = false;
    }
    //
    if ( [[gameBoard objectAtIndex:2] integerValue] + [[gameBoard objectAtIndex:5] integerValue] + [[gameBoard objectAtIndex:8] integerValue] == 3) {
        winner = [NSNumber numberWithInteger:1];
        playing = false;
    }
    if ( [[gameBoard objectAtIndex:2] integerValue] + [[gameBoard objectAtIndex:5] integerValue] + [[gameBoard objectAtIndex:8] integerValue] == -3) {
        winner = [NSNumber numberWithInteger:-1];
        playing = false;
    }
    // HERE ARE THE ROWS
    if ( [[gameBoard objectAtIndex:0] integerValue] + [[gameBoard objectAtIndex:1] integerValue] + [[gameBoard objectAtIndex:2] integerValue] == 3) {
        winner = [NSNumber numberWithInteger:1];
        playing = false;
    }
    if ( [[gameBoard objectAtIndex:0] integerValue] + [[gameBoard objectAtIndex:1] integerValue] + [[gameBoard objectAtIndex:2] integerValue] == -3) {
        winner = [NSNumber numberWithInteger:-1];
        playing = false;
    }
    //
    if ( [[gameBoard objectAtIndex:3] integerValue] + [[gameBoard objectAtIndex:4] integerValue] + [[gameBoard objectAtIndex:5] integerValue] == 3) {
        winner = [NSNumber numberWithInteger: 1];
        playing = false;
    }
    if ( [[gameBoard objectAtIndex:3] integerValue] + [[gameBoard objectAtIndex:4] integerValue] + [[gameBoard objectAtIndex:5] integerValue] == -3) {
        winner = [NSNumber numberWithInteger:-1];
        playing = false;
    }
    //
    if ( [[gameBoard objectAtIndex:6] integerValue] + [[gameBoard objectAtIndex:7] integerValue] + [[gameBoard objectAtIndex:8] integerValue] == 3) {
        winner = [NSNumber numberWithInteger:1];
        playing = false;
    }
    if ( [[gameBoard objectAtIndex:6] integerValue] + [[gameBoard objectAtIndex:7] integerValue] + [[gameBoard objectAtIndex:8] integerValue] == -3) {
        winner = [NSNumber numberWithInteger:-1];
        playing = false;
    }
    //DIAGONALSSSSSSSSS
    if ( [[gameBoard objectAtIndex:0] integerValue] + [[gameBoard objectAtIndex:4] integerValue] + [[gameBoard objectAtIndex:8] integerValue] == 3) {
        winner = [NSNumber numberWithInteger:1];
        playing = false;
    }
    if ( [[gameBoard objectAtIndex:0] integerValue] + [[gameBoard objectAtIndex:4] integerValue] + [[gameBoard objectAtIndex:8] integerValue] == -3) {
        winner = [NSNumber numberWithInteger:-1];
        playing = false;
    }
    //
    if ( [[gameBoard objectAtIndex:2] integerValue] + [[gameBoard objectAtIndex:4] integerValue] + [[gameBoard objectAtIndex:6] integerValue] == 3) {
        winner = [NSNumber numberWithInteger:1];
        playing = false;
    }
    if ( [[gameBoard objectAtIndex:2] integerValue] + [[gameBoard objectAtIndex:4] integerValue] + [[gameBoard objectAtIndex:6] integerValue] == -3) {
        winner = [NSNumber numberWithInteger:-1];
        playing = false;
    }
 
    return winner;
}

- (Boolean) computerPlace: (int) index
{
    if (playing == true){
    if ([[gameBoard objectAtIndex:index] integerValue] == 0){
        if (x == true){
            [gameBoard setObject:[NSNumber numberWithInteger:1] atIndexedSubscript:index];
            x = false;
        }
        else if (x == false){
            [gameBoard setObject:[NSNumber numberWithInteger:-1] atIndexedSubscript:index];
            x = true;
        }
        [self printGame];
        return true;
    }
    [self printGame];
    }
    return false;
}

- (void) playerPlace:(int)index
{
    if (xTurn == true){
        if ([[gameBoard objectAtIndex:index] integerValue] == 0){
            [gameBoard setObject:[NSNumber numberWithInt:1] atIndexedSubscript:index];
            [self printGame];
    }
        else if (xTurn == false){
            if ([[gameBoard objectAtIndex:index] integerValue] == 0){
                [gameBoard setObject:[NSNumber numberWithInt:-1] atIndexedSubscript:index];
                [self printGame];
            }
        }
    }
}
- (void) xPlace: (int) index
{
    [gameBoard setObject:[NSNumber numberWithInt:1] atIndexedSubscript:index];
}
- (void) oPlace: (int) index
{
    [gameBoard setObject:[NSNumber numberWithInt:-1] atIndexedSubscript:index];
}
- (Boolean) isPlaying
{
    return playing;
}
- (Boolean) xTurn
{
    return x;
}

- (void) setIsPlayingFalse
{
    playing = false;
}
- (void) endGame
{
    playing = false;
    if (xTurn == true){
        myTurn = true;
    }
    else if (xTurn == false){
        myTurn = false;
    }
}
- (Boolean) isMyTurn
{
    return myTurn;
}
- (void) printGame
{
    NSLog(@"------------------");
    NSLog(@"%ld      %ld      %ld", (long)[gameBoard[0] integerValue], (long)[gameBoard[1] integerValue], (long)[gameBoard[2] integerValue]);
    NSLog(@"------------------");
    NSLog(@"%ld      %ld      %ld", (long)[gameBoard[3] integerValue], (long)[gameBoard[4] integerValue], (long)[gameBoard[5] integerValue]);
    NSLog(@"-------------------");
    NSLog(@"%ld      %ld      %ld", (long)[gameBoard[6] integerValue], (long)[gameBoard[7] integerValue], (long)[gameBoard[8] integerValue]);
    NSLog(@"------------------");
}
@end
