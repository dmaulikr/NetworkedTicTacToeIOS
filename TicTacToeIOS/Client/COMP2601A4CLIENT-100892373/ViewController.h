//
//  ViewController.h
//  COMP2601A4CLIENT-100892373
//
//  Created by Julian Clayton on 2015-03-31.
//  Copyright (c) 2015 Julian Clayton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connector.h"
@class Connector;
@interface ViewController : UITableViewController <NSNetServiceDelegate>
@property (strong, nonatomic) IBOutlet UITableView *initialTableView;


@end

