//
//  PlaygroundPanelSketchPanelCellDefault.h
//  PluginPlayground
//
//  Created by Suresh V Selvaraj on 6/2/18.
//  Copyright © 2018 Suresh V Selvaraj. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PlaygroundPanelSketchPanelCell.h"

@interface PlaygroundPanelSketchPanelCellDefault : PlaygroundPanelSketchPanelCell

@property (nonatomic, weak) IBOutlet NSTextField *titleLabel;
@property (nonatomic, weak) IBOutlet NSImageView *imageView;

@end
