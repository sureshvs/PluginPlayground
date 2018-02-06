//
//  PlaygroundPanelSketchPanelCell.m
//  PluginPlayground
//
//  Created by Suresh V Selvaraj on 6/2/18.
//  Copyright © 2018 Suresh V Selvaraj. All rights reserved.
//

#import "PlaygroundPanelSketchPanelCell.h"

@interface PlaygroundPanelSketchPanelCell ()

@end

@implementation PlaygroundPanelSketchPanelCell

- (NSView *)view {
    return self;
}

+ (instancetype)loadNibNamed:(NSString *)nibName {
    NSNib *nib = [[NSNib alloc] initWithNibNamed:nibName bundle:[NSBundle bundleForClass:[self class]]];
    NSArray *views;
    [nib instantiateWithOwner:nil topLevelObjects:&views];

    NSArray *filtered = [views filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[self class]];
    }]];

    return [filtered firstObject];
}

@end
