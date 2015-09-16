//
//  Game.h
//  COMP2601A3-100892373
//
//  Created by Julian Clayton on 2015-03-06.
//  Copyright (c) 2015 Julian Clayton. All rights reserved.
//

#import <Foundation/Foundation.h>
///YRYEYAUINDJJKFEHB
@interface Game : NSObject
{
    NSMutableArray *gameBoard;
    Boolean x;
    Boolean playing;
    Boolean xTurn;
    Boolean myTurn;

}
- (void) inititializeBoard;
- (void) newGame;
- (NSMutableArray *) getGameBoard;
- (NSNumber *) checkWin;
- (Boolean) checkForDraw;
- (Boolean) computerPlace: (int) index;
- (void) playerPlace: (int) index;
- (int) computeNextMove;
- (Boolean) isPlaying;

- (Boolean) xTurn;//Use this to decide which player is x and which is O
- (void) setXTurn: (Boolean) xt;
- (Boolean) getXTurn;
- (Boolean) isMyTurn; //if it is this players turn
-(void) setMyTurn: (Boolean) mt;
- (void) printGame;
- (void) setIsPlayingFalse;
- (void) endGame;
- (void) xPlace: (int) index;
- (void) oPlace: (int) index;
+ (Game *) gameInstance;

@end
