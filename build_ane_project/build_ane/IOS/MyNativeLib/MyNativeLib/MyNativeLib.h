//
//  MyNativeLib.h
//  MyNativeLib
//
//  Copyright © 2015年 薛旻. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"


void ExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);

void ExtensionFinalizer(void* extData);

void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);

void ContextFinalizer(FREContext ctx);

#define ANE_FUNCTION(f) FREObject (f)(FREContext ctx, void *data, uint32_t argc, FREObject argv[])
#define MAP_FUNCTION(f, data) { (const uint8_t*)(#f), (data), &(f) }


ANE_FUNCTION(getNativeData);

/**************************************************/
NSString * getStringFromFREObject(FREObject obj);
FREObject createFREString(NSString * string);

double getDoubleFromFREObject(FREObject obj);
FREObject createFREDouble(double value);

int getIntFromFREObject(FREObject obj);
FREObject createFREInt(int value);

BOOL getBoolFromFREObject(FREObject obj);
FREObject createFREBool(BOOL value);

void dispatchStatusEventAsync(NSString * code, NSString * level);
