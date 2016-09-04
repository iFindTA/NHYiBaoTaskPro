//
//  AppDelegate.m
//  NHYiBaoTaskPro
//
//  Created by hu jiaju on 16/8/16.
//  Copyright © 2016年 Nanhu. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "YBMsgRootCtr.h"
#import "YBTaskRootCtr.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIColor *color = [UIColor colorWithRed:58/255.f green:181/255.f blue:172/255.f alpha:1];
    [[UINavigationBar appearance] setBarTintColor:color];
    [[UINavigationBar appearance] setTranslucent:false];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    YBMsgRootCtr *msgCtr = [[YBMsgRootCtr alloc] init];
    UINavigationController *msgNavi = [[UINavigationController alloc] initWithRootViewController:msgCtr];
    msgCtr.title = @"消息";
    
    YBTaskRootCtr *taskCtr = [[YBTaskRootCtr alloc] init];
    UINavigationController *taskNavi = [[UINavigationController alloc] initWithRootViewController:taskCtr];
    taskCtr.title = @"任务";
    
    UIViewController *preCtr = [[UIViewController alloc] init];
    UINavigationController *preNavi = [[UINavigationController alloc] initWithRootViewController:preCtr];
    preCtr.title = @"预约";
    
    UIViewController *huanCtr = [[UIViewController alloc] init];
    UINavigationController *huanNavi = [[UINavigationController alloc] initWithRootViewController:huanCtr];
    huanCtr.title = @"患者";
    
    UIViewController *mineCtr = [[UIViewController alloc] init];
    UINavigationController *mineNavi = [[UINavigationController alloc] initWithRootViewController:mineCtr];
    mineCtr.title = @"我的";
    
    tabBar.viewControllers = @[msgNavi, taskNavi, preNavi, huanNavi, mineNavi];
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
