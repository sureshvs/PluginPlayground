//
//  PlaygroundPanelMSInspectorStackView.h
//  PluginPlayground
//
//  Created by Suresh V Selvaraj on 6/2/18.
//  Copyright © 2018 Suresh V Selvaraj. All rights reserved.
//

#ifndef PlaygroundPanelMSInspectorStackView_h
#define PlaygroundPanelMSInspectorStackView_h

@protocol PlaygroundPanelMSInspectorStackView <NSObject>

@property (nonatomic, strong) NSArray *sectionViewControllers;
- (void)reloadWithViewControllers:(NSArray *)controllers;

@end

#endif /* PlaygroundPanelMSInspectorStackView_h */
