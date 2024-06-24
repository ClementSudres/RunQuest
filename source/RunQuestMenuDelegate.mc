import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class RunQuestMenuDelegate extends WatchUi.Menu2InputDelegate {
    var appView = getApp().getAppView();
    var appDelegate = getApp().getAppDelegate();

    function initialize() {
        Menu2InputDelegate.initialize();
        System.println("RunQuestMenuDelegate init");
    }

    function createMenu(){
        var menu = new CustomMenu(80, Graphics.COLOR_BLACK, {});
        menu.addItem(
            new CustomMenuItem( // a WatchUi.CustomMenuItem
                :itemOne,
                {:drawable=>new CustomItem("Runner", Rez.Drawables.Defis_Runner_badges, 0.70)}
            )
        );
        menu.addItem(
            new CustomMenuItem( // a WatchUi.CustomMenuItem
                :itemTwo,
                {:drawable=>new CustomItem("Calories", Rez.Drawables.Defis_Cal_badges, 0.20)}
            )
        );
        menu.addItem(
            new CustomMenuItem( // a WatchUi.CustomMenuItem
                :itemTwo,
                {:drawable=>new CustomItem("Quizz", Rez.Drawables.Defis_Quizz_badges, 0.40)}
            )
        );
        return menu;
    }

    function onMenuItem(item as Symbol) as Void {
        
        if (item == :Programme) {
            WatchUi.switchToView(new ProgrammeView(), new ProgrammeDelegate(), WatchUi.SLIDE_DOWN);
        } else if (item == :Statistiques) {
            WatchUi.switchToView(new StatsView(), new StatsDelegate(), WatchUi.SLIDE_DOWN);
        }else if (item == :Defis) {
            WatchUi.switchToView(createMenu(), new DefisDelegate(), WatchUi.SLIDE_DOWN);
        }else if (item == :Annuler){
            WatchUi.switchToView(appView, appDelegate, WatchUi.SLIDE_DOWN);
        }
    }
}