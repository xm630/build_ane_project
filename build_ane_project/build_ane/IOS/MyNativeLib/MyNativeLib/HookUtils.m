//
//  HookUtils.m
//  ResearchMethodSwizzl
//
//  Created by 薛旻 on 15/4/27.
//  Copyright (c) 2015年 薛旻. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>


@interface HookUtils : NSObject

+ (void)hookMehod:(SEL)oldSEL andDef:(SEL)defaultSEL andNew:(SEL)newSEL;

@end

@implementation HookUtils

+ (void)hookMehod:(SEL)oldSEL andDef:(SEL)defaultSEL andNew:(SEL)newSEL {
    NSLog(@"hookMehod");
    
    Class oldClass = objc_getClass([@"CTAppDelegate" UTF8String]);
   
    Class newClass = [HookUtils class];
    
    //把方法加给原Class
    class_addMethod(oldClass, newSEL, class_getMethodImplementation(newClass, newSEL), nil);
    class_addMethod(oldClass, oldSEL, class_getMethodImplementation(newClass, defaultSEL),nil);
    
    Method oldMethod = class_getInstanceMethod(oldClass, oldSEL);
    assert(oldMethod);
    Method newMethod = class_getInstanceMethod(oldClass, newSEL);
    assert(newMethod);
    method_exchangeImplementations(oldMethod, newMethod);
    
}

+ (void)load {
    NSLog(@"load");
    [self hookMehod:@selector(application:didFinishLaunchingWithOptions:) andDef:@selector(defaultApplication:didFinishLaunchingWithOptions:) andNew:@selector(hookedApplication:didFinishLaunchingWithOptions:)];
    
    [self hookMehod:@selector(applicationWillEnterForeground:) andDef:@selector(defaultApplicationWillEnterForeground:) andNew:@selector(hookedApplicationWillEnterForeground:)];
}


/*具体要走的代码*/
-(BOOL)hookedApplication:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)dic
{
    NSLog(@"applicationDidFinishLaunching");
    [self hookedApplication:application didFinishLaunchingWithOptions:dic];
    return YES;
}

- (void)hookedApplicationWillResignActive:(UIApplication *)application {
    [self hookedApplicationWillResignActive:application];
}

- (void)hookedApplicationDidEnterBackground:(UIApplication *)application {
    [self hookedApplicationDidEnterBackground:application];
}

- (void)hookedApplicationWillEnterForeground:(UIApplication *)application {
    [self hookedApplicationWillEnterForeground:application];
}

- (void)hookedApplicationDidBecomeActive:(UIApplication *)application {
    [self hookedApplicationDidBecomeActive:application];
}

- (void)hookedApplicationWillTerminate:(UIApplication *)application {
    [self hookedApplicationWillTerminate:application];
}

/*支付宝对应的方法*/
- (BOOL)hookedApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [self hookedApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    return YES;
}



-(BOOL)hookedApplication:(UIApplication*)application handleOpenURL:(NSURL*)url {
    [self hookedApplication:application handleOpenURL:url];
    return YES;
}


#pragma 默认
/*default 默认不需要改动*/
- (BOOL)defaultApplication:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)dic { return YES;
}

- (void)defaultApplicationWillResignActive:(UIApplication *)application {}

- (void)defaultApplicationDidEnterBackground:(UIApplication *)application {}

- (void)defaultApplicationWillEnterForeground:(UIApplication *)application {}

- (void)defaultApplicationDidBecomeActive:(UIApplication *)application {}

- (void)defaultApplicationWillTerminate:(UIApplication *)application {}

- (BOOL)defaultApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return YES;
}

- (BOOL)defaultApplication:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return YES;
}

@end
