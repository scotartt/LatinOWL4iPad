//
//  OWLSearchViewController.m
//  LatinOWL4iPad
//
//  Created by Scot Mcphee on 30/03/13.
//  Copyright (c) 2013 Scot Mcphee. All rights reserved.
//

#import "OWLSearchViewController.h"

@interface OWLSearchViewController ()

@end


@implementation OWLSearchViewController

    @synthesize delegate;
    @synthesize searchText;


    - (IBAction)search:(id)sender {
        [delegate doSearch:[searchText text]];
    }


    - (IBAction)cancel:(id)sender {
        [delegate dismissSearch:[searchText text]];
    }


    - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
        }
        return self;
    }


    - (void)viewDidLoad {
        [super viewDidLoad];
    }


    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }


    - (BOOL)textFieldShouldReturn:(UITextField *)textField {
        NSLog(@"textfield return was pressed.");
        [self search:textField];
        return YES;
    }

@end
