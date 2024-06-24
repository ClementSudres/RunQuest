import Toybox.Lang;
import Toybox.WatchUi;

class RunQuestDelegate extends WatchUi.BehaviorDelegate {

    var mainMenu;
    var runQuestMenuDelegate;

    function initialize() {
        BehaviorDelegate.initialize();
        System.println("RunQuestDelegate init");
    }

    function onMenu() as Boolean {
        mainMenu = new Rez.Menus.MainMenu();
        runQuestMenuDelegate = new RunQuestMenuDelegate();
        WatchUi.switchToView(mainMenu, runQuestMenuDelegate, WatchUi.SLIDE_DOWN);
        return true;
    }

    function onStart() as Boolean {
        WatchUi.switchToView(new RunWalkView(), new RunWalkDelegate(), WatchUi.SLIDE_DOWN);
        return true; 
    }

    function getMainMenu(){
        return mainMenu;
    }

    function getRunQuestMenuDelegate(){
        return runQuestMenuDelegate;
    }

}