//
//  OWLMasterViewController.h
//  LatinOWL4iPad
//
//  Created by Scot Mcphee on 30/03/13.
//  Copyright (c) 2013 Scot Mcphee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OWLDetailViewController;

@interface OWLMasterViewController : UITableViewController

@property (strong, nonatomic) OWLDetailViewController *detailViewController;

@end
