//
//  LatinOWL4iPad
//
//  Created by Scot Mcphee on 30/03/13.
//  Copyright (c) 2013 Scot Mcphee. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface OWLButtonFactory : NSObject

    @property id target;

    + (id)initButtonsForTarget:(id)controller;

    - (UIBarButtonItem *)createCustomNavButtonWithIcon:(NSString *)iconName andSelectorAction:(SEL)action width:(int)width height:(int)height;

    - (UIButton *)createUIButtonWithIcon:(NSString *)iconName andSelectorAction:(SEL)action width:(int)width height:(int)height;
@end
