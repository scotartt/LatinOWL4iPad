//
//  LatinOWL4iPad
//
//  Created by Scot Mcphee on 31/03/13.
//  Copyright (c) 2013 Scot Mcphee. All rights reserved.
//


#import "OWLButtonFactory.h"


@implementation OWLButtonFactory

    @synthesize target;


    + (id)initButtonsForTarget:(id)controller {
        OWLButtonFactory *factory = [[OWLButtonFactory alloc] init];
        [factory setTarget:controller];
        return factory;
    }

#pragma create a custom 28x28 button for use on the nav bar
    - (UIBarButtonItem *)createCustomNavButtonWithIcon:(NSString *)iconName andSelectorAction:(SEL)action width:(int)width height:(int)height {
        UIButton *uiButton = [self createUIButtonWithIcon:iconName andSelectorAction:action width:width height:height];
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:uiButton];
        return barButton;
    }




#pragma create a UI Button
    - (UIButton *)createUIButtonWithIcon:(NSString *)iconName andSelectorAction:(SEL)action width:(int)width height:(int)height {
        UIButton *uiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *butImageB = [UIImage imageNamed:iconName];
        [uiButton setBackgroundImage:butImageB forState:UIControlStateNormal];
        [uiButton addTarget:[self target] action:action forControlEvents:UIControlEventTouchUpInside];
        uiButton.frame = CGRectMake(0, 0, width, height);
        return uiButton;
    }

@end
