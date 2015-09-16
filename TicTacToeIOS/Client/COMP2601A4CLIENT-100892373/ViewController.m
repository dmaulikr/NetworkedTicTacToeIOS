//
//  ViewController.m
//  COMP2601A4CLIENT-100892373
//
//  Created by Julian Clayton on 2015-03-31.
//  Copyright (c) 2015 Julian Clayton. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "Connector.h"
#import "GameViewController.h"
#import "Game.h"


@interface ViewController ()
{
    NSNetService *oponent;
    GCDAsyncSocket *clientSocket;
}
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(serverUpdate:) name:@"serversUpdate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameRequestRecieved:) name:@"gameRequestReceived" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(segueToGame:) name:@"segueToGame" object:nil];
    [[Connector connectorInstance] initConnector];

    usleep(100);
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[Connector connectorInstance] getServers] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.name.text = [[[[Connector connectorInstance] getServers]objectAtIndex:indexPath.row]name];
    
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[Game gameInstance] setXTurn:true];
    [[Game gameInstance] setMyTurn:true];
    [[Connector connectorInstance] setOpponent:[[[Connector connectorInstance] getServers] objectAtIndex:indexPath.row]];
    [[Connector connectorInstance] resolveAddress:[[Connector connectorInstance] getOpponent]];
    
 
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [[Connector connectorInstance] sendGameResponse:clientSocket :@"NO" ];
        [[[Connector connectorInstance] getClientSocket] disconnect];
        [[[Connector connectorInstance] getServerSocket] disconnect];
    }
    if (buttonIndex == 1){
        [self performSegueWithIdentifier:@"SEGUE_IDENTIFIER" sender:self];
        [[Game gameInstance] setXTurn:false];
        [[Game gameInstance] setMyTurn:false];
        [[Connector connectorInstance] sendGameResponse: clientSocket :@"YES"];
    }
}

- (void) serverUpdate: (NSNotification*) notification
{
    [[self tableView] reloadData];
}
- (void) gameRequestRecieved: (NSNotification*) notification
{
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:NSLocalizedString(@"play_game", nil) message:[[[Connector connectorInstance]getOpponent] name] delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:NSLocalizedString(@"ok", nil),nil];
    clientSocket = [notification object];
    
    if ([[Game gameInstance] isPlaying] == false){
        [messageAlert show];
    }
}
- (void) segueToGame: (NSNotification *) notification
{
    [self performSegueWithIdentifier:@"SEGUE_IDENTIFIER" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SEGUE_IDENTIFIER"]) {
        GameViewController *gameViewController = (GameViewController *)segue.destinationViewController;
    }
}
 @end
