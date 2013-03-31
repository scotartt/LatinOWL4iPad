//
//  OWLDetailViewController.m
//  LatinOWL4iPad
//
//  Created by Scot Mcphee on 30/03/13.
//  Copyright (c) 2013 Scot Mcphee. All rights reserved.
//

#import "OWLDetailViewController.h"


@interface OWLDetailViewController ()

    @property(strong, nonatomic) UIPopoverController *masterPopoverController;

    - (void)configureView;

@end


@implementation OWLDetailViewController

    @synthesize theURL;
    @synthesize activityIndicator;
    @synthesize webView;

#pragma mark - Managing the detail item

    - (void)setDetailItem:(id)newDetailItem {
        if (_detailItem != newDetailItem) {
            _detailItem = newDetailItem;

            // Update the view.
            [self configureView];
        }

        if (self.masterPopoverController != nil) {
            [self.masterPopoverController dismissPopoverAnimated:YES];
        }
    }


    - (void)configureView {
        [self.activityIndicator stopAnimating];
    }


    - (void)viewDidAppear:(BOOL)animated {
    }


    - (void)viewDidLoad {
        [super viewDidLoad];
        NSURL *aURL = [NSURL URLWithString:theURL];
        NSLog(@"Getting url:%@", aURL);
        NSURLRequest *request = [NSURLRequest requestWithURL:aURL];
        [self.webView loadRequest:request];
        [self.webView setDelegate:self];
        [self configureView];
    }


    - (void)viewWillAppear:(BOOL)animated {
        [super viewWillAppear:animated];
        [[self navigationItem] setTitle:self.title];
        // [self.navigationController setNavigationBarHidden:NO animated:animated];
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
        [self.activityIndicator stopAnimating];
    }


    - (void)webView:(UIWebView *)webView1 didFailLoadWithError:(NSError *)error {
        [self.activityIndicator stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Web view error" message:[error description]
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
