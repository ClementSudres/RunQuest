import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application;

class RunQuestDelegate extends WatchUi.BehaviorDelegate {
    var chronoView; 
    var chronoDelegate;

    var mainMenu;
    var runQuestMenuDelegate;

    function initialize() {
        BehaviorDelegate.initialize();
        System.println("RunQuestDelegate init");
    }

    //affiche le menu avec les stats, défis, et programme 
    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new RunQuestMenuDelegate(), WatchUi.SLIDE_DOWN);
        mainMenu = new Rez.Menus.MainMenu();
        runQuestMenuDelegate = new RunQuestMenuDelegate();
        WatchUi.switchToView(mainMenu, runQuestMenuDelegate, WatchUi.SLIDE_DOWN);
        return true;
    }

    //lance le run walk 
    function onSelect() as Boolean {
        System.println(Storage.getValue("echauffement") + " echauffement");
        if(Storage.getValue("echauffement")!=null){
            chronoView = new RunWalkView(Storage.getValue("echauffement"));
            chronoDelegate = new RunWalkDelegate(Storage.getValue("echauffement"), Storage.getValue("tempsCircuit"), Storage.getValue("tempsPause"));
        }else{
            chronoView = new RunWalkView(getApp().chrono);
            chronoDelegate = new RunWalkDelegate(getApp().chrono, getApp().tempsCircuit, getApp().tempsPause);
        }
        WatchUi.switchToView(chronoView, chronoDelegate, WatchUi.SLIDE_DOWN);
        return true; 
    }

    //les getteurs 
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