/*
// To load this framework, add the following code in your manifest.json

"commands": [
:
:
{
    "script" : "PlaygroundPanel.framework/PlaygroundPanel.js",
    "handlers" : {
        "actions" : {
            "Startup" : "onStartup",
            "OpenDocument":"onOpenDocument",
            "SelectionChanged.finish" : "onSelectionChanged"
        }
    }
}
]
*/

var onStartup = function(context) {
  var PlaygroundPanel_FrameworkPath = PlaygroundPanel_FrameworkPath || COScript.currentCOScript().env().scriptURL.path().stringByDeletingLastPathComponent().stringByDeletingLastPathComponent();
  var PlaygroundPanel_Log = PlaygroundPanel_Log || log;
  (function() {
    var mocha = Mocha.sharedRuntime();
    var frameworkName = "PlaygroundPanel";
    var directory = PlaygroundPanel_FrameworkPath;
    if (mocha.valueForKey(frameworkName)) {
      PlaygroundPanel_Log("🤔 " + frameworkName + " already loaded.");
      return true;
    } else if ([mocha loadFrameworkWithName:frameworkName inDirectory:directory]) {
      PlaygroundPanel_Log("✅ Loaded `" + frameworkName + "` successfully!");
      mocha.setValue_forKey_(true, frameworkName);
      return true;
    } else {
      PlaygroundPanel_Log("❌ Failed to load " + frameworkName + "!: " + directory + ". Please define PlaygroundPanel_FrameworkPath if you're trying to @import in a custom plugin");
      return false;
    }
  })();
};

var onShutdown = function(context) {
    PlaygroundPanel.onShutdown(context);
}

var onSelectionChanged = function(context) {
    PlaygroundPanel.onSelectionChanged(context);
};
