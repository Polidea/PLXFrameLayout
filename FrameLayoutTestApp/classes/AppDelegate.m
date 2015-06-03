//
//  AppDelegate.m
//  FrameLayoutTestApp
//
//  Created by Pawel Scibek on 01/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "AppDelegate.h"
#import "ListViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    ListViewController *mainViewController = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    navigationController.navigationBar.translucent = NO;

    CGRect frame = [[UIScreen mainScreen] bounds];
    UIWindow *window = [[UIWindow alloc] initWithFrame:frame];
    window.rootViewController = navigationController;
    [window makeKeyAndVisible];
    self.window = window;

    return YES;
}

@end
