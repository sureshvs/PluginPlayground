//
//  PlaygroundPanel.m
//  PluginPlayground
//
//  Created by Suresh V Selvaraj on 6/2/18.
//  Copyright © 2018 Suresh V Selvaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dlfcn.h>
#import "PlaygroundPanel.h"
#import <CocoaScript/COScript.h>
@import JavaScriptCore;
#import <Mocha/Mocha.h>
#import <Mocha/MOClosure.h>
#import <Mocha/MOJavaScriptObject.h>
#import <Mocha/MochaRuntime_Private.h>

@protocol MAMSDocument <NSObject>

@optional
- (void)showMessage:(NSString *)theMessage;
@end


@interface PlaygroundPanel : NSObject


+ (void)onShutdown:(id)context;
+ (void)onSelectionChanged:(id)context;

@end



@implementation PlaygroundPanel

+ (void)onSelectionChanged:(id)context {
    id <MAMSDocument> document = [context valueForKeyPath:@"actionContext.document"];
    [document showMessage:@"v1"];
//    [document showMessage:@"v2"]; 
}

+ (void)onShutdown:(id)context {
    NSLog(@"shutting down");
    NSString *frameworkPath = [[Mocha sharedRuntime] valueForKey:@"frameworkPath"];
    NSString *diyaFrameworkPath = [NSString stringWithFormat:@"%@/PlaygroundPanel.framework/PlaygroundPanel", frameworkPath];
    char *error;
    void *frameworkHandle = dlopen([diyaFrameworkPath UTF8String], RTLD_NOW);
    if ((error = dlerror()) != NULL)  {
        fprintf(stderr, "%s\n", error);
    }
    if (frameworkHandle != nil) {
        [[Mocha sharedRuntime] setNilValueForKey:@"PlaygroundPanel"];
        
        int result;
        result = dlclose(frameworkHandle);
        if ((error = dlerror()) != NULL)  {
            fprintf(stderr, "%s\n", error);
        }
        NSLog(@"closed framework, with result: %d", result);
    }

}

@end
