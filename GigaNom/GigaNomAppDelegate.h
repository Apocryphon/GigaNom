//
//  GigaNomAppDelegate.h
//  GigaNom
//
//  Created by Richard Yeh on 4/7/12.
//  Copyright (c) 2012 UC Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GigaNomViewController;

@interface GigaNomAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GigaNomViewController *rootViewController;

@end
