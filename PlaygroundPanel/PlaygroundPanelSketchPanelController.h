//
//  PlaygroundPanelSketchPanelController.h
//  PluginPlayground
//
//  Created by Suresh V Selvaraj on 6/2/18.
//  Copyright © 2018 Suresh V Selvaraj. All rights reserved.
//

@import Cocoa;
#import "PlaygroundPanelMSDocument.h"
#import "PlaygroundPanelMSInspectorStackView.h"
#import "PlaygroundPanelSketchPanelDataSource.h"
@class PlaygroundPanelSketchPanel;

@interface PlaygroundPanelSketchPanelController : NSObject <PlaygroundPanelSketchPanelDataSource>

@property (nonatomic, weak, readonly) id <PlaygroundPanelMSInspectorStackView> stackView; // MSInspectorStackView
@property (nonatomic, weak, readonly) id <PlaygroundPanelMSDocument> document;
@property (nonatomic, strong, readonly) PlaygroundPanelSketchPanel *panel;

- (instancetype)initWithDocument:(id <PlaygroundPanelMSDocument>)document;
- (void)selectionDidChange:(NSArray *)selection;

@end
