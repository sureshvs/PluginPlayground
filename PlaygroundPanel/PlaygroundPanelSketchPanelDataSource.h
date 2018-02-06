//
//  PlaygroundPanelSketchPanelDataSource.h
//  PluginPlayground
//
//  Created by Suresh V Selvaraj on 6/2/18.
//  Copyright © 2018 Suresh V Selvaraj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlaygroundPanelSketchPanel;
@class PlaygroundPanelSketchPanelCell;

@protocol PlaygroundPanelSketchPanelDataSource <NSObject>

- (NSUInteger)numberOfRowsForPlaygroundPanelSketchPanel:(PlaygroundPanelSketchPanel *)panel;
- (PlaygroundPanelSketchPanelCell *)PlaygroundPanelSketchPanel:(PlaygroundPanelSketchPanel *)panel itemForRowAtIndex:(NSUInteger)index;
- (PlaygroundPanelSketchPanelCell *)headerForPlaygroundPanelSketchPanel:(PlaygroundPanelSketchPanel *)panel;

@end
