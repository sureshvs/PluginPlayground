//
//  PlaygroundPanelSketchPanelCell.h
//  PluginPlayground
//
//  Created by Suresh V Selvaraj on 6/2/18.
//  Copyright © 2018 Suresh V Selvaraj. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PlaygroundPanelSketchPanelCell;

@interface PlaygroundPanelSketchPanelCell : NSView

@property (nonatomic, copy) NSString *reuseIdentifier;

+ (instancetype)loadNibNamed:(NSString *)nibName;

@end
