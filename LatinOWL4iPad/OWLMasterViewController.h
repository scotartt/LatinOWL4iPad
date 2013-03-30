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

@class OWLDetailViewController;
@class OWLMorphData;


@interface OWLMasterViewController : UITableViewController <OWLSearchViewControllerDelegate, UIPopoverControllerDelegate, OWLMorphDataObserver>

@property (strong, nonatomic) OWLDetailViewController *detailViewController;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

    @property(nonatomic, strong) OWLMorphData *latinMorphData;
@end
