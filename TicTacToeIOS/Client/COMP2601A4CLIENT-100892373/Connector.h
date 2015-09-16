//
//  Connector.h
//  COMP2601A4CLIENT-100892373
//
//  Created by Julian Clayton on 2015-03-31.
//  Copyright (c) 2015 Julian Clayton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "Message.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <CFNetwork/CFSocketStream.h>
#import "ViewController.h"
#import "GCDAsyncSocket.h"
#import "CustomCell.h"
#import "Message.h"

@interface Connector : NSObject <NSNetServiceDelegate, NSNetServiceBrowserDelegate, GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *listenSocket;
    GCDAsyncSocket *serverSocket;
    GCDAsyncSocket *clientSocket;
    NSMutableArray *connectedSockets;
    NSNetService *netService;
    NSNetServiceBrowser *netServiceBrowser;
    int port;
    NSMutableArray *servers;
    NSOperationQueue *operationQueue;
    NSNotificationCenter *notificationCentre;
    NSString *serviceName;
    NSNetService *opponent;
}

- (void) initConnector;
- (BOOL) startNetServiceBrowser;
- (NSMutableArray*) getServers;
- (Message *)jsonToMessage: (NSData *) data;
- (void)resolveAddress:(NSNetService *)sender;
- (void) sendMessage: (Message *) message: (GCDAsyncSocket *) socket: (long) tag;

+ (Connector *) connectorInstance;
- (void) setOpponent: (NSNetService *) o;
- (NSNetService *) getOpponent;
- (GCDAsyncSocket *) getServerSocket;
- (GCDAsyncSocket *) getClientSocket;

- (void) sendGameResponse: (GCDAsyncSocket *) socket: (NSString *) answer;
- (void) sendGameOn: (GCDAsyncSocket *) socket;
- (void) sendGameOver: (GCDAsyncSocket *) socket: (NSString *) reason;
- (void) sendMoveMessage: (GCDAsyncSocket *) socket: (NSString *) location;
- (void) sendGameWon: (GCDAsyncSocket *) socket;
- (void) sendGameQuit: (GCDAsyncSocket *) socket;
@end
