import Toybox.Lang;
import Toybox.WatchUi;

class RunQuestDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.switchToView(new Rez.Menus.MainMenu(), new RunQuestMenuDelegate(), WatchUi.SLIDE_DOWN);
        return true;
    }

    function onStart() as Boolean {
        WatchUi.switchToView(new RunWalkView(), new RunWalkDelegate(), WatchUi.SLIDE_DOWN);
        return true; 
    }

}