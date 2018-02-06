//
//  PlaygroundPanelSketchPanelController.m
//  PluginPlayground
//
//  Created by Suresh V Selvaraj on 6/2/18.
//  Copyright © 2018 Suresh V Selvaraj. All rights reserved.
//

#import "PlaygroundPanelSketchPanelController.h"
#import "PlaygroundPanelSketchPanelCell.h"
#import "PlaygroundPanelSketchPanelCellHeader.h"
#import "PlaygroundPanelSketchPanelCellDefault.h"
#import "PlaygroundPanelSketchPanel.h"
#import "PlaygroundPanelSketchPanelDataSource.h"


@interface PlaygroundPanelSketchPanelController ()

@property (nonatomic, weak) id <PlaygroundPanelMSInspectorStackView> stackView; // MSInspectorStackView
@property (nonatomic, weak) id <PlaygroundPanelMSDocument> document;
@property (nonatomic, strong) PlaygroundPanelSketchPanel *panel;
@property (nonatomic, copy) NSArray *selection;

@end

@implementation PlaygroundPanelSketchPanelController

- (instancetype)initWithDocument:(id <PlaygroundPanelMSDocument>)document {
    if (self = [super init]) {
        _document = document;
        _panel = [[PlaygroundPanelSketchPanel alloc] initWithStackView:nil];
        _panel.datasource = self;
    }
    return self;
}

- (void)selectionDidChange:(NSArray *)selection {
    self.selection = [selection valueForKey:@"layers"];         // To get NSArray from MSLayersArray

    self.panel.stackView = [(NSObject *)_document valueForKeyPath:@"inspectorController.currentController.stackView"];
    [self.panel reloadData];
}

#pragma mark - PlaygroundPanelSketchPanelDataSource

- (PlaygroundPanelSketchPanelCell *)headerForPlaygroundPanelSketchPanel:(PlaygroundPanelSketchPanel *)panel {
    PlaygroundPanelSketchPanelCellHeader *cell = (PlaygroundPanelSketchPanelCellHeader *)[panel dequeueReusableCellForReuseIdentifier:@"header"];
    if ( ! cell) {
        cell = [PlaygroundPanelSketchPanelCellHeader loadNibNamed:@"PlaygroundPanelSketchPanelCellHeader"];
        cell.reuseIdentifier = @"header";
    }
    cell.titleLabel.stringValue = @"PlaygroundPanel";
    return cell;
}

- (NSUInteger)numberOfRowsForPlaygroundPanelSketchPanel:(PlaygroundPanelSketchPanel *)panel {
    return self.selection.count;    // Using self.selection as number of rows in the panel
}

- (PlaygroundPanelSketchPanelCell *)PlaygroundPanelSketchPanel:(PlaygroundPanelSketchPanel *)panel itemForRowAtIndex:(NSUInteger)index {
    PlaygroundPanelSketchPanelCellDefault *cell = (PlaygroundPanelSketchPanelCellDefault *)[panel dequeueReusableCellForReuseIdentifier:@"cell"];
    if ( ! cell) {
        cell = [PlaygroundPanelSketchPanelCellDefault loadNibNamed:@"PlaygroundPanelSketchPanelCellDefault"];
        cell.reuseIdentifier = @"cell";
    }

    id layer = self.selection[index];
    cell.titleLabel.stringValue = [layer name];
    cell.imageView.image = [layer valueForKeyPath:@"previewImages.LayerListPreviewUnfocusedImage"];

    return cell;
}

@end
