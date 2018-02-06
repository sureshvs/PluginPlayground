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
#import "PlaygroundPanelSketchPanelController.h"
@import JavaScriptCore;
#import <Mocha/Mocha.h>
#import <Mocha/MOClosure.h>
#import <Mocha/MOJavaScriptObject.h>
#import <Mocha/MochaRuntime_Private.h>


@interface PlaygroundPanel : NSObject

@property (nonatomic, strong) PlaygroundPanelSketchPanelController *panelController;
@property (nonatomic, strong) id <PlaygroundPanelMSDocument> document;
@property (nonatomic, copy) NSString *panelControllerClassName;

+ (instancetype)onSelectionChanged:(id)context;
+ (void)onShutdown:(id)context;
- (void)onSelectionChange:(NSArray *)selection;
+ (void)setSharedCommand:(id)command;

@end



@implementation PlaygroundPanel

static id _command;
static NSString* const arrayOfInstanceKeysKey = @"arrayOfInstanceKeys";

+ (void)setSharedCommand:(id)command {
    _command = command;
}

+ (id)sharedCommand {
    return _command;
}

+ (instancetype)onSelectionChanged:(id)context {
    id <PlaygroundPanelMSDocument> document = [context valueForKeyPath:@"actionContext.document"];
    if ( ! [document isKindOfClass:NSClassFromString(@"MSDocument")]) {
        document = nil;  // be safe
        return nil;
    }

    if ( ! [self sharedCommand]) {
        [self setSharedCommand:[context valueForKeyPath:@"command"]]; // MSPluginCommand
    }

    NSString *key = [NSString stringWithFormat:@"%@-PlaygroundPanel", [document description]];
    __block PlaygroundPanel *instance = [[Mocha sharedRuntime] valueForKey:key];

    if ( ! instance) {
        instance = [[self alloc] initWithDocument:document];
        [[Mocha sharedRuntime] setValue:instance forKey:key];
        
        NSMutableArray *arrayOfInstanceKeys = [[Mocha sharedRuntime] valueForKey:arrayOfInstanceKeysKey];
        if ( !arrayOfInstanceKeys ) {
            arrayOfInstanceKeys = [NSMutableArray new];
        }
        [arrayOfInstanceKeys addObject:key];
        [[Mocha sharedRuntime] setValue:arrayOfInstanceKeys forKey:arrayOfInstanceKeysKey];
    }

    NSArray *selection = [context valueForKeyPath:@"actionContext.document.selectedLayers"];
//    NSLog(@"selection %p %@ %@", instance, key, selection);
    [instance onSelectionChange:selection];
    return instance;
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
        //Get the list of keys and unload each one manually
        NSArray *instanceKeys = [[Mocha sharedRuntime] valueForKey:arrayOfInstanceKeysKey];
        for (NSString *instanceKey in instanceKeys) {
            __block PlaygroundPanel *instance = [[Mocha sharedRuntime] valueForKey:instanceKey];
            [instance unloadMemberVariables];
            
            [[Mocha sharedRuntime] setValue:[NSNull null] forKey:instanceKey];
        }
        //Finally, set the key value to blank string. (Ideally, we want to set nil, but Mocha doesn't like it for some reason.
        [[Mocha sharedRuntime] setValue:[NSNull null] forKey:arrayOfInstanceKeysKey];
        
        int result;
        result = dlclose(frameworkHandle);
        if ((error = dlerror()) != NULL)  {
            fprintf(stderr, "%s\n", error);
        }
        NSLog(@"closed framework, with result: %d", result);
    }

}

- (void)unloadMemberVariables {
    _document = nil;
    _panelController = nil;
}

- (instancetype)initWithDocument:(id <PlaygroundPanelMSDocument>)document {
    if (self = [super init]) {
//        _document = document;
//        _panelController = [[PlaygroundPanelSketchPanelController alloc] initWithDocument:_document];
    }
    return self;
}

- (void)onSelectionChange:(NSArray *)selection {
    [_panelController selectionDidChange:selection];
}

@end
