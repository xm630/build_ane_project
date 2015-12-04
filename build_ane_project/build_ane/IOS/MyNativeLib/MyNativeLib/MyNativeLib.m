//
//  MyNativeLib.m
//  MyNativeLib
//
//  Copyright © 2015年 薛旻. All rights reserved.
//

#import "MyNativeLib.h"

FREContext mContext;

void ExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    NSLog(@"Entering ExtensionInitializer()");
    
    *extDataToSet = NULL;
    *ctxInitializerToSet = &ContextInitializer; //传入Context初始化方法
    *ctxFinalizerToSet = &ContextFinalizer; //传入Context结束方法
    
    NSLog(@"Exiting ExtensionInitializer()");}

void ExtensionFinalizer(void* extData) {
    NSLog(@"Entering ExtensionFinalizer()");
    // 可以做清理工作.
    NSLog(@"Exiting ExtensionFinalizer()");
}

void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {
    
    mContext = ctx;
    
    static FRENamedFunction func[] =
    {
        MAP_FUNCTION(getNativeData, NULL)
    };
    
    *numFunctionsToTest = sizeof(func) / sizeof(FRENamedFunction);
    *functionsToSet = func;
}

void ContextFinalizer(FREContext ctx) {
    NSLog(@"Entering ContextFinalizer()");
    // 可以做清理工作
    NSLog(@"Exiting ContextFinalizer()");
}


ANE_FUNCTION(getNativeData)
{
    int params1 = getIntFromFREObject(argv[0]);
    NSString *params2 = getStringFromFREObject(argv[1]);
    NSString * nativeData = [[NSString new] initWithFormat:@"%d%@",params1,params2];
    
    dispatchStatusEventAsync(@"nativeCallbackSuccess",@"iosCallback"); // 回调
    
    return createFREString(nativeData);
}

void dispatchStatusEventAsync(NSString * code, NSString * level)
{
    if(mContext!= nil)
    {
        FREDispatchStatusEventAsync(mContext, (const uint8_t *) [code UTF8String], (const uint8_t *) [level UTF8String]);
    }
    else
    {
        NSLog(@"FREContext is null");
    }
}

/*
 *  utils function
 */

/*--------------------------------string------------------------------------*/
NSString * getStringFromFREObject(FREObject obj)
{
    uint32_t length;
    const uint8_t *value;
    FREGetObjectAsUTF8(obj, &length, &value);
    return [NSString stringWithUTF8String:(const char *)value];
}

FREObject createFREString(NSString * string)
{
    const char *str = [string UTF8String];
    FREObject obj;
    
    FRENewObjectFromUTF8(strlen(str)+1, (const uint8_t*)str, &obj);
    return obj;
}
/*-------------------------------double-----------------------------------*/
double getDoubleFromFREObject(FREObject obj)
{
    double number;
    FREGetObjectAsDouble(obj, &number);
    return number;
}
FREObject createFREDouble(double value)
{
    FREObject obj = nil;
    FRENewObjectFromDouble(value, &obj);
    return obj;
}
/*---------------------------------int---------------------------------*/
int getIntFromFREObject(FREObject obj)
{
    int32_t number;
    FREGetObjectAsInt32(obj, &number);
    return number;
}
FREObject createFREInt(int value)
{
    FREObject obj = nil;
    FRENewObjectFromInt32(value, &obj);
    return obj;
}
/*------------------------------bool----------------------------------------*/
BOOL getBoolFromFREObject(FREObject obj)
{
    uint32_t boolean;
    FREGetObjectAsBool(obj, &boolean);
    return boolean;
}

FREObject createFREBool(BOOL value)
{
    FREObject obj = nil;
    FRENewObjectFromBool(value, &obj);
    return obj;
}



