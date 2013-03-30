//
//  OWLSearchViewController.h
//  LatinOWL4iPad
//
//  Created by Scot Mcphee on 30/03/13.
//  Copyright (c) 2013 Scot Mcphee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OWLSearchViewControllerDelegate;


@interface OWLSearchViewController : UIViewController <UITextFieldDelegate>

    @property(strong, nonatomic) IBOutlet UITextField *searchText;
    @property(weak) id <OWLSearchViewControllerDelegate> delegate;

    - (IBAction)search:(id)sender;

    - (IBAction)cancel:(id)sender;

@end


@protocol OWLSearchViewControllerDelegate <NSObject>
@required
    - (void)dismissSearch:(NSString *)value;

    - (void)doSearch:(NSString *)value;
@end
