//
//  PlaygroundPanelSketchPanel.h
//  PluginPlayground
//
//  Created by Suresh V Selvaraj on 6/2/18.
//  Copyright © 2018 Suresh V Selvaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaygroundPanelSketchPanelDataSource.h"
#import "PlaygroundPanelMSInspectorStackView.h"

@class PlaygroundPanelSketchPanelCell;

@interface PlaygroundPanelSketchPanel : NSObject

@property (nonatomic, strong, readonly) NSArray *views;
@property (nonatomic, weak) id <PlaygroundPanelMSInspectorStackView> stackView;
@property (nonatomic, weak) id <PlaygroundPanelSketchPanelDataSource> datasource;

- (instancetype)initWithStackView:(id <PlaygroundPanelMSInspectorStackView>)stackView;
- (void)reloadData;
- (PlaygroundPanelSketchPanelCell *)dequeueReusableCellForReuseIdentifier:(NSString *)identifier;

@end
