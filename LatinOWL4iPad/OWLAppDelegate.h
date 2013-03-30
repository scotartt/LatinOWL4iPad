//
//  OWLAppDelegate.h
//  LatinOWL4iPad
//
//  Created by Scot Mcphee on 30/03/13.
//  Copyright (c) 2013 Scot Mcphee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@class Reachability;

static NSString *const hostName = @"www.perseus.tufts.edu";


@interface OWLAppDelegate : UIResponder <UIApplicationDelegate> {
        Reachability *hostReach;
    }

    @property(strong, nonatomic) UIWindow *window;
    @property(strong, nonatomic) UIAlertView *netAlert;
    @property(strong, nonatomic) UIStoryboard *storyBoard;

    - (NSString *)stringFromStatus:(NetworkStatus)status;

@end
