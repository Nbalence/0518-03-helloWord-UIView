//
//  AppDelegate.m
//  02-UIViewDemo
//
//  Created by qingyun on 16/3/22.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建window
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor whiteColor];
    window.hidden = NO;
    self.window = window;
    
    
    //设置根视图控制器
    UIViewController *VC = [[UIViewController alloc] init];
    self.window.rootViewController = VC;
    VC.view.backgroundColor = [UIColor cyanColor];

    
    //添加蓝色viewA
    UIView *viewA = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    [self.window addSubview:viewA];
    //背景颜色
    viewA.backgroundColor = [UIColor blueColor];
    //透明度
    viewA.alpha = 0.6;
    viewA.userInteractionEnabled = NO;
    
    
    //在viewA上添加红色viewB
    UIView *viewB = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [viewA addSubview:viewB];
    viewB.backgroundColor = [UIColor redColor];
    viewB.alpha = 1.0;
    
    //在viewA上插入绿色viewC（索引0）
    UIView *viewC = [[UIView alloc] initWithFrame:CGRectMake(100, 20, 200, 300)];
    [viewA insertSubview:viewC atIndex:0];
    viewC.backgroundColor = [UIColor greenColor];
    viewC.tag = 100;
    
    //把viewA从父视图中删除
    //[viewA removeFromSuperview];
    
    //交换两个字数图的层次结构
    [viewA exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    //在红色viewB上添加一个viewD
    UIView *viewD = [[UIView alloc] initWithFrame:CGRectMake(10, 50, 200, 200)];
    [viewA insertSubview:viewD aboveSubview:viewB];
    viewD.backgroundColor = [UIColor purpleColor];
    
    //在viewC下添加viewE
    UIView *viewE = [[UIView alloc] initWithFrame:CGRectMake(50, 20, 200, 200)];
    [viewA insertSubview:viewE belowSubview:viewC];
    viewE.backgroundColor = [UIColor yellowColor];
    
    
    //把红色viewB置顶
    [viewA bringSubviewToFront:viewB];
    
    //把绿色viewC置底
    [viewA sendSubviewToBack:viewC];
    //NSLog(@"viewA.superview:%@",viewA.superview);
    
    //利用tag值找到viewC
    UIView *viewF = [viewA viewWithTag:100];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [viewA addGestureRecognizer:tap];
    
    return YES;
}

-(void)tap:(UITapGestureRecognizer *)tap{
    NSLog(@"%s",__func__);
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.hnqingyun._2_UIViewDemo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"_2_UIViewDemo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"_2_UIViewDemo.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
