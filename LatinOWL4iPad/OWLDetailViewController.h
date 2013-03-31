//
//  OWLDetailViewController.h
//  LatinOWL4iPad
//
//  Created by Scot Mcphee on 30/03/13.
//  Copyright (c) 2013 Scot Mcphee. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OWLDetailViewController : UIViewController <UISplitViewControllerDelegate, UIWebViewDelegate, NSURLConnectionDelegate>

    @property(strong, nonatomic) id detailItem;
    @property(strong, nonatomic) IBOutlet UIWebView *webView;
    @property(strong, nonatomic) NSString *theURL;
    @property(strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
