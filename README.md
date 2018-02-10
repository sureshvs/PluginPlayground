# PluginPlayground

This is a basic framework based plugin for testing unloading a framework in onShutdown

# Testing Procedure
## Part 1
1. Build the plugin from Xcode
2. In Xcode navigator, expand the 'Products' folder.
3. Right click on PluginPlayground.sketchplugin and select 'Show in Finder'
4. Double click the plugin to install it in Sketch
5. Select a layer. A message "v1" will be displayed in the Sketch document window

## Part 2
1. In Xcode, open manifest.json and change the "version" from 1 to 2
2. In PlaygroundPanel.m, under onSelectionChanged, comment out the statement
```[document showMessage:@"v1"];```
3. Right below, uncomment the statement
```[document showMessage:@"v2"];```
4. Build the plugin again
5. Again, navigate to the folder where the plugin was built
6. Double click the plugin to install it in Sketch

# Expected Result
The plugin framework should've been updated, so selecting a layer should show the message "v2"

# Actual Result
Looks like the framework doesn't get unloaded. So we continue to get the message "v1". If we restart Sketch and then select a layer, the message "v2" is displayed
