//
//  Message.m
//  COMP2601A4CLIENT-100892373
//
//  Created by Julian Clayton on 2015-03-31.
//  Copyright (c) 2015 Julian Clayton. All rights reserved.
//

#import "Message.h"

@implementation Message
@synthesize head, body;


- (NSData *)messageToJSON
{
    NSDictionary *msg = [NSDictionary dictionaryWithObjectsAndKeys: head, @"head",
                         body, @"body",
                         nil];
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:msg options:0 error:&error];
    return data;
}

+ (Message *)jsonToMessage: (NSData *) data
{
    Message *msg = [[Message alloc] init];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:NSJSONReadingMutableContainers
                          error:&error];
    
    msg.head = [json objectForKey:@"head"];
    msg.body = [json objectForKey:@"body"];
    return msg;
}
@end

