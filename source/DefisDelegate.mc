import Toybox.Lang;
import Toybox.WatchUi;

class DefisDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onStart() as Boolean {
        //WatchUi.switchToView(view, delegate, transition);
        return true; 
    }

    function onBack(){
        WatchUi.switchToView(getApp().getAppView(), getApp().getAppDelegate(), WatchUi.SLIDE_DOWN);
    }

}