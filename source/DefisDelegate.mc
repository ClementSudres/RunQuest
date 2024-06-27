import Toybox.Lang;
import Toybox.WatchUi;

class DefisDelegate extends WatchUi.Menu2InputDelegate {
    
    var appView = getApp().getAppView();
    var appDelegate = getApp().getAppDelegate();

    var mainMenu = getApp().getAppDelegate().getMainMenu();
    var runQuestMenuDelegate = getApp().getAppDelegate().getRunQuestMenuDelegate();

    function initialize() {
        Menu2InputDelegate.initialize();
        System.println("DefisDelegate init");
    }

    function onStart() as Boolean {
        //WatchUi.switchToView(view, delegate, transition);
        return true; 
    }

    function onBack(){
        WatchUi.switchToView(mainMenu, runQuestMenuDelegate, WatchUi.SLIDE_DOWN);
        System.println("Print");
    }

}

