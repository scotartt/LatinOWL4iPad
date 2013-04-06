//
//  OWLDetailViewController.m
//  LatinOWL4iPad
//
//  Created by Scot Mcphee on 30/03/13.
//  Copyright (c) 2013 Scot Mcphee. All rights reserved.
//

#import "OWLDetailViewController.h"
#import "OWLButtonFactory.h"


@interface OWLDetailViewController ()

    @property(strong, nonatomic) UIPopoverController *masterPopoverController;

    - (void)configureView;

@end


@implementation OWLDetailViewController

    @synthesize activityIndicator;
    @synthesize webView;

#pragma mark - Managing the detail item

    - (void)setDetailItem:(id)newDetailItem {
        if (_detailItem != newDetailItem) {
            _detailItem = newDetailItem;
            [self.webView setHidden:YES];
            // Update the view.
            [self configureView];
        }
        if (self.masterPopoverController != nil) {
            [self.masterPopoverController dismissPopoverAnimated:YES];
        }
    }


    - (void)configureView {
        [[self navigationItem] setTitle:self.title];
        if (_detailItem) {
            NSURL *url = [NSURL URLWithString:(NSString *) _detailItem];
            NSLog(@"Getting url:%@", url);
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
            request.HTTPShouldHandleCookies = NO;
            [self.webView loadRequest:request];
            [self.webView setDelegate:self];
        }
    }


    - (void)viewDidAppear:(BOOL)animated {
    }


    - (void)viewDidLoad {
        [super viewDidLoad];
        [self configureView];
    }


    - (void)viewWillAppear:(BOOL)animated {
        [super viewWillAppear:animated];

        OWLButtonFactory *buttonFactory = [OWLButtonFactory initButtonsForTarget:self];
        UIBarButtonItem *backButton = [buttonFactory createCustomNavButtonWithIcon:@"09-arrow-west.png" andSelectorAction:@selector(goBack:) width:19 height:16];
        UIBarButtonItem *fwdButton = [buttonFactory createCustomNavButtonWithIcon:@"02-arrow-east.png" andSelectorAction:@selector(goFwd:) width:19 height:16];
        UIBarButtonItem *stopButton = [buttonFactory createCustomNavButtonWithIcon:@"60-x.png" andSelectorAction:nil width:14 height:14];
        UIBarButtonItem *reloadButton = [buttonFactory createCustomNavButtonWithIcon:@"01-refresh.png" andSelectorAction:@selector(goReload:) width:24 height:26];
        NSArray *rightButtons = [NSArray arrayWithObjects:stopButton, fwdButton, backButton, nil];
        self.navigationItem.rightBarButtonItems = rightButtons;
        NSArray *leftButtons = [NSArray arrayWithObjects:reloadButton, nil];
        self.navigationItem.leftBarButtonItems = leftButtons;
    }


    - (void)goReload:(id)sender {
        if (_detailItem) {
            [self configureView];
        } else {
            if ([self.webView isHidden]) {
                [self.webView setHidden:NO];
            }
            [self.webView reload];
        }
    }


    - (void)goStop:(id)sender {
        if ([self.webView isHidden]) {
            [self.webView setHidden:NO];
        }
        [self.webView stopLoading];
        [self.activityIndicator stopAnimating];
    }


    - (void)goFwd:(id)sender {
        if (_detailItem && self.webView && [self.webView canGoForward]) {
            [self.webView goForward];
        }
    }


    - (void)goBack:(id)sender {
        if (_detailItem && self.webView && [self.webView canGoBack]) {
            [self.webView goBack];
        }
    }


    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

#pragma mark UIWebViewDelegate


    - (void)webViewDidStartLoad:(UIWebView *)webView1 {
        [self.activityIndicator startAnimating];
    }


    - (void)webViewDidFinishLoad:(UIWebView *)webView1 {
        [self.webView setHidden:NO];
        [self.activityIndicator stopAnimating];
    }


    - (void)webView:(UIWebView *)webView1 didFailLoadWithError:(NSError *)error {
        [self.activityIndicator stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Web view error" message:[error description]
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }


#pragma mark - Split view

    - (void)splitViewController:(UISplitViewController *)splitController
         willHideViewController:(UIViewController *)viewController
              withBarButtonItem:(UIBarButtonItem *)barButtonItem
           forPopoverController:(UIPopoverController *)popoverController {

        barButtonItem.title = NSLocalizedString(@"Master", @"Master");
        [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
        self.masterPopoverController = popoverController;
    }


    - (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
        // Called when the view is shown again in the split view, invalidating the button and popover controller.
        [self.navigationItem setLeftBarButtonItem:nil animated:YES];
        self.masterPopoverController = nil;
    }

@end
