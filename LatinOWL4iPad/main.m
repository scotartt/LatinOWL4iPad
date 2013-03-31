//
//  main.m
//  LatinOWL4iPad
//
//  Created by Scot Mcphee on 30/03/13.
//  Copyright (c) 2013 Scot Mcphee. All rights reserved.
//

#import "OWLAppDelegate.h"


int main(int argc, char *argv[]) {
    @autoreleasepool {
        @try {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([OWLAppDelegate class]));
        } @catch (id ex) {
            NSLog(@"Exception in main: %@", [ex description]);
            @throw ex;
        }
    }
}
