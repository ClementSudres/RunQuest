import Toybox.Lang;
import Toybox.WatchUi;

class RunWalkDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
        System.println("RunWalkDelegate init");
    }

    function onMenu() as Boolean {
        WatchUi.switchToView(new Rez.Menus.MainMenu(), new RunQuestMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onStart() as Boolean {
        //WatchUi.switchToView(view, delegate, transition);
        return true; 
    }

    function onBack(){
        WatchUi.switchToView(getApp().getAppView(), getApp().getAppDelegate(), WatchUi.SLIDE_DOWN);
        return true;
    }

}