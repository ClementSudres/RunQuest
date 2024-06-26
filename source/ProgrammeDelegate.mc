import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Timer;

class ProgrammeDelegate extends WatchUi.Menu2InputDelegate {
    var menuDelegate = getApp().getAppDelegate().getRunQuestMenuDelegate();

    function initialize() {
        Menu2InputDelegate.initialize();
        System.println("ProgrammeDelegate init");
    }

    function onSelect(item){
        if(item.getId().equals("Deb")){
            menuDelegate.menuProg.getItem(0).setIcon(new Bitmap({:rezId=>Rez.Drawables.favori,:locX=>10,:locY=>30}));
            menuDelegate.menuProg.getItem(1).setIcon(new Bitmap({:rezId=>Rez.Drawables.Nfavori,:locX=>10,:locY=>30}));
        }else{
            menuDelegate.menuProg.getItem(0).setIcon(new Bitmap({:rezId=>Rez.Drawables.Nfavori,:locX=>10,:locY=>30}));
            menuDelegate.menuProg.getItem(1).setIcon(new Bitmap({:rezId=>Rez.Drawables.favori,:locX=>10,:locY=>30}));
        }
    }
    
}
