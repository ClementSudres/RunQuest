import Toybox.Lang;
import Toybox.WatchUi;

class RunQuestDelegate extends WatchUi.BehaviorDelegate {
    var chronoView; 
    var chronoDelegate;

    var mainMenu;
    var runQuestMenuDelegate;

    function initialize() {
        BehaviorDelegate.initialize();
        System.println("RunQuestDelegate init");
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new RunQuestMenuDelegate(), WatchUi.SLIDE_DOWN);
        mainMenu = new Rez.Menus.MainMenu();
        runQuestMenuDelegate = new RunQuestMenuDelegate();
        WatchUi.switchToView(mainMenu, runQuestMenuDelegate, WatchUi.SLIDE_DOWN);
        return true;
    }

    function onSelect() as Boolean {
        chronoView = new RunWalkView(10);
        chronoDelegate = new RunWalkDelegate(10, 5, 3);
        WatchUi.switchToView(chronoView, chronoDelegate, WatchUi.SLIDE_DOWN);
        return true; 
    }

    function getChronoView(){
        return chronoView;
    }
    function getChronoDelegate(){
        return chronoDelegate;
    }

    function getMainMenu(){
        return mainMenu;
    }

    function getRunQuestMenuDelegate(){
        return runQuestMenuDelegate;
    }

}