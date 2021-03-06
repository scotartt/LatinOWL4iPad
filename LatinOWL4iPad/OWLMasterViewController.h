//
//  OWLMasterViewController.h
//  LatinOWL4iPad
//
//  Created by Scot Mcphee on 30/03/13.
//  Copyright (c) 2013 Scot Mcphee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWLSearchViewController.h"
#import "OWLMorphDataObserver.h"
#import "OWLHistoryViewController.h"

@class OWLDetailViewController;
@class OWLMorphData;


@interface OWLMasterViewController : UITableViewController <OWLSearchViewControllerDelegate, OWLHistoryViewControllerDelegate, UIPopoverControllerDelegate, OWLMorphDataObserver>

    @property(strong, nonatomic) OWLDetailViewController *detailViewController;
    @property(strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
    @property(strong, nonatomic) OWLMorphData *latinMorphData;
    @property(strong, nonatomic) NSMutableArray *history;
    @property(strong, nonatomic) NSString *lastSearch;
    @property BOOL useLastSearch;

@end
