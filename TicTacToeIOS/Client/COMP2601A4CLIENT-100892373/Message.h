//
//  Message.h
//  COMP2601A4CLIENT-100892373
//
//  Created by Julian Clayton on 2015-03-31.
//  Copyright (c) 2015 Julian Clayton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
{
    NSDictionary *head;
    NSDictionary *body;
}
@property (strong, nonatomic) NSDictionary *head;
@property (strong, nonatomic) NSDictionary *body;

- (NSData *)messageToJSON;
+ (Message *)jsonToMessage:(NSData*)data;

@end