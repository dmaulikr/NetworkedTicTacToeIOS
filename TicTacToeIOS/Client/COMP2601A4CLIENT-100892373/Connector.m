//
//  Connector.m
//  COMP2601A4CLIENT-100892373
//
//  Created by Julian Clayton on 2015-03-31.
//  Copyright (c) 2015 Julian Clayton. All rights reserved.
//
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <CFNetwork/CFSocketStream.h>
#import "Connector.h"
#import "GCDAsyncSocket.h"
#import "Message.h"
#import "ViewController.h"
#import "ViewController.h"
#import "Message.h"
#import "Game.h"

@implementation Connector 

- (void) initConnector
{
    listenSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    connectedSockets = [[NSMutableArray alloc]initWithCapacity:1];
    servers = [[NSMutableArray alloc] init];
    notificationCentre = [NSNotificationCenter defaultCenter];
    serviceName = @"JCService01";
       if (! [self startNetServiceBrowser])
    {
        NSLog(@"Browser Failed");
    }
    if (! [self publishService])
    {
        NSLog(@"Service Failed");
    }
 
    //[netServiceBrowser searchForServicesOfType:@"_JService._tcp." inDomain: @""];
}
+ (Connector *) connectorInstance
{
    static Connector *connectorInstance;
    @synchronized(self)
    {
        if (!connectorInstance)
            connectorInstance = [[Connector alloc] init];
        return connectorInstance;
    }
}
- (void) setOpponent:(NSNetService *)o
{
    opponent = o; 
}
- (NSNetService *) getOpponent
{
    return opponent;
}
- (GCDAsyncSocket *) getClientSocket
{
    return clientSocket;
}
- (GCDAsyncSocket *) getServerSocket
{
    return serverSocket;
}

- (BOOL) publishService
{
    NSError *error;
    NSString* myService = serviceName;
    listenSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    [listenSocket acceptOnPort:0 error:&error];
    netService = [[NSNetService alloc] initWithDomain:@"" type:@"_ttt._tcp." name:myService port: [listenSocket localPort]];
    if (self->netService == nil){
        return NO;
    }
    [netService scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [self->netService setDelegate:(id)self];
    [netService publish];
    return YES;
}

- (void) unPublishService {
    if (self->netService) {
        [self->netService stop];
        [self->netService removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        self->netService = nil;
    }
}
- (void) netService: (NSNetService*)sender didNotPublish:(NSDictionary *)errorDict
{
    NSLog(@"did not publish");
    if (sender != self->netService){
        return;
    }
    [self unPublishService];
}
- (void) netServiceDidPublish: (NSNetService *) sender
{
    NSLog(@"netService Published");
}

- (BOOL) startNetServiceBrowser
{
    netServiceBrowser = [[NSNetServiceBrowser alloc] init];
    if (!netServiceBrowser){
        NSLog(@"Browser Not Started");
        return NO;
    }
    netServiceBrowser.delegate = self;
    [netServiceBrowser scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
 
    [netServiceBrowser searchForServicesOfType:@"_ttt._tcp." inDomain: @""];
    [notificationCentre postNotificationName:@"serversUpdate" object:servers];
        
    return YES;
}


-(void) netServiceBrowser: (NSNetServiceBrowser *) netServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
    //netService = aNetService;
    [aNetService resolveWithTimeout:10];
    NSLog(@"found");
    
    if (! [servers containsObject:aNetService])
    {
       //[netService setDelegate:self];
        //[netService resolveWithTimeout:3.0];
        [servers addObject:aNetService];
        [notificationCentre postNotificationName:@"serversUpdate" object:servers];
    }
    if (moreComing){
        return;
    }
    for (int i = 0; i < [servers count]; i++){
        NSLog(@"%@", [[servers objectAtIndex:i] name]);
    }
    
}

- (void)resolveAddress:(NSNetService *)service {

    NSError *error  = nil;
    
    if (![clientSocket connectToHost: service.hostName onPort: service.port error:&error]){
        [self close];
    }
    NSLog(@"Connected to %@ on port %ld with address: %@", [service name], (long)[service port], [service hostName]);
    
    Message *playGameRequest = [[Message alloc] init];
    NSString *type = @"type";
    NSDictionary *head = [[NSDictionary alloc] initWithObjectsAndKeys:@"PLAY_GAME_REQUEST", type, nil];
    NSDictionary *body = [[NSDictionary alloc] initWithObjectsAndKeys:serviceName, @"source",
                                                                        [service name], @"destination",
                                                                        nil];
    [playGameRequest setHead:head];
    [playGameRequest setBody:body];
    [self sendMessage:playGameRequest :clientSocket :2];
    [clientSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:-1];
}

- (void) close {
    [self unPublishService];
    [servers removeAllObjects];
    [clientSocket disconnect];
}
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    newSocket.delegate = self;
    [newSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:-1];
    serverSocket = newSocket;
    
    NSLog(@"SocketAccepted");

}
-(void) socket:(GCDAsyncSocket *)sender didWriteDataWithTag:(long)tag
{
    if (tag == 1)
        NSLog(@"Message with tag 1 sent");
    else if (tag == 2)
        NSLog(@"Message with tag 2 sent");
    else if (tag == 3)
        NSLog(@"Start game sent");
}

- (void) socket:(GCDAsyncSocket *)sender didReadData:(NSData *)data withTag:(long)tag
{
    if (sender == serverSocket)
    {
        Message *incomingMsg = [Message jsonToMessage:data];
        
        if ([[[incomingMsg head] valueForKey:@"type" ]  isEqual: @"PLAY_GAME_REQUEST"]){
            NSLog(@"Received from client: %@", [[incomingMsg head] valueForKey:@"type"]);
            NSString *opponentName = [[incomingMsg body] valueForKey:@"source"];
            NSLog(@"%@", opponentName);
            [notificationCentre postNotificationName:@"serversUpdate" object:servers];
            [notificationCentre postNotificationName:@"gameRequestReceived" object:sender];
            
        }
        if ([[[incomingMsg head] valueForKey:@"type"] isEqual: @"PLAY_GAME_RESPONSE"]){
            NSLog(@"PLay game response recieved");
        }
        if ([[[incomingMsg head] valueForKey:@"type"] isEqual: @"GAME_ON"]){
            [[Game gameInstance] newGame];
            [notificationCentre postNotificationName:@"newGameStartedByOpponent" object:nil];
        }
        if ([[[incomingMsg head] valueForKey:@"type"] isEqual: @"GAME_OVER"]){
            [[Game gameInstance] endGame];
            [notificationCentre postNotificationName:@"gameStoppedByOpponent" object:nil];
        }
        if ([[[incomingMsg head] valueForKey:@"type"] isEqual: @"MOVE_MESSAGE"]){
            [[Game gameInstance] setMyTurn:true];
            NSString *tile = [[incomingMsg body] valueForKey:@"tile"];
            [notificationCentre postNotificationName:@"opponentMove" object:tile];
        }
        if ([[[incomingMsg head] valueForKey:@"type"] isEqual: @"GAME_WON"]){
            [notificationCentre postNotificationName:@"gameWon" object:nil];
        }
        if ([[[incomingMsg head] valueForKey:@"type"] isEqual: @"QUIT_GAME"]){
              [notificationCentre postNotificationName:@"gameQuit" object:nil];
        }
    }
    
    if (sender == clientSocket)
    {
        Message *incomingMsg = [Message jsonToMessage:data];
        
        if ([[[incomingMsg head] valueForKey:@"type"] isEqual: @"PLAY_GAME_RESPONSE"]){
            if ([[[incomingMsg body] valueForKey:@"answer" ] isEqual: @"YES"]){
                [notificationCentre postNotificationName:@"segueToGame" object:nil];
                }
            }
            if ([[[incomingMsg body] valueForKey:@"answer"] isEqual: @"NO"]){
                NSLog(@"Declined");
                [serverSocket disconnect];
                [clientSocket disconnect];
            }
            if ([[[incomingMsg head] valueForKey:@"type"] isEqual: @"GAME_ON"]){
                NSLog(@"Game On");
                [[Game gameInstance] newGame];
                [notificationCentre postNotificationName:@"newGameStartedByOpponent" object:nil];
            }
            if ([[[incomingMsg head] valueForKey:@"type"] isEqual: @"GAME_OVER"]){
                NSLog(@"GAME OVER");
                [[Game gameInstance] endGame];
                [notificationCentre postNotificationName:@"gameStoppedByOpponent" object:nil];
            }
            if ([[[incomingMsg head] valueForKey:@"type"] isEqual: @"MOVE_MESSAGE"]){
                [[Game gameInstance] setMyTurn:true];
                NSString *tile = [[incomingMsg body] valueForKey:@"tile"];
                [notificationCentre postNotificationName:@"opponentMove" object:tile];
            }
            if ([[[incomingMsg head] valueForKey:@"type"] isEqual: @"GAME_WON"]){
                [notificationCentre postNotificationName:@"gameWon" object:nil];
            }
            if ([[[incomingMsg head] valueForKey:@"type"] isEqual: @"QUIT_GAME"]){
                [notificationCentre postNotificationName:@"gameQuit" object:nil];            }
        }
    [sender readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:tag];
}

- (NSMutableArray*) getServers
{
    return servers;
}
- (void) sendMessage:(Message *)message: (GCDAsyncSocket *)socket: (long)tag
{
    NSData *jsonMessage = [message messageToJSON];
    [socket writeData:jsonMessage withTimeout:-1 tag:tag];
    [socket writeData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:tag];
}
- (void) sendGameResponse:(GCDAsyncSocket *) socket: (NSString *) answer
{
    Message *playGameResponseYes = [[Message alloc] init];
    NSString *type = @"type";
    NSDictionary *head = [[NSDictionary alloc] initWithObjectsAndKeys:@"PLAY_GAME_RESPONSE", type, nil];
    NSDictionary *body = [[NSDictionary alloc] initWithObjectsAndKeys:answer, @"answer",
                          nil];
    [[Game gameInstance] setMyTurn:false];
    [[Game gameInstance] setXTurn:false];
    [playGameResponseYes setHead:head];
    [playGameResponseYes setBody:body];
    [self sendMessage:playGameResponseYes :socket :2];
}

- (void) sendGameOn:(GCDAsyncSocket *)socket
{
    Message *gameOn = [[Message alloc] init];
    NSString *type = @"type";
    NSDictionary *head = [[NSDictionary alloc] initWithObjectsAndKeys:@"GAME_ON", type, nil];
    [gameOn setHead:head];
    [self sendMessage:gameOn :socket :3];
}

- (void) sendGameOver:(GCDAsyncSocket *)socket :(NSString *)reason
{
    Message *gameOver = [[Message alloc] init];
    NSString *type = @"type";
    NSDictionary *head = [[NSDictionary alloc] initWithObjectsAndKeys:@"GAME_OVER",type, nil];
    NSDictionary *body = [[NSDictionary alloc] initWithObjectsAndKeys:reason, @"reason",
                          nil];
    [gameOver setHead:head];
    [gameOver setBody:body];
    [self sendMessage:gameOver :socket :2];
}
- (void) sendGameWon: (GCDAsyncSocket *) socket
{
    Message *gameWon = [[Message alloc] init];
    NSString *type = @"type";
    NSDictionary *head = [[NSDictionary alloc] initWithObjectsAndKeys:@"GAME_WON", type, nil];
    [gameWon setHead:head];
    [self sendMessage:gameWon :socket :2];
}
- (void) sendMoveMessage:(GCDAsyncSocket *)socket :(NSString *)location
{
    Message *moveMessage = [[Message alloc] init];
    NSString *type = @"type";
    NSDictionary *head = [[NSDictionary alloc] initWithObjectsAndKeys:@"MOVE_MESSAGE", type,
                         nil];
    NSDictionary *body = [[NSDictionary alloc] initWithObjectsAndKeys: location, @"tile", nil];
    [moveMessage setHead:head];
    [moveMessage setBody:body];
    [self sendMessage:moveMessage :socket:2];
}
- (void) sendGameQuit:(GCDAsyncSocket *)socket
{
    Message *quitMessage = [[Message alloc] init];
    NSString *type = @"type";
    NSDictionary *head = [[NSDictionary alloc] initWithObjectsAndKeys:@"QUIT_GAME", type, nil];
    [quitMessage setHead:head];
    [self sendMessage:quitMessage :socket:2];
}
@end

