import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class RunQuestApp extends Application.AppBase {
    var view;
    var delegate;
    
    //si pas stocker dans la montre détermine le programme par défaut 
    var chrono=10;
    var tempsCircuit=5;
    var tempsPause=3;
    var periode=0; //0 représente l'echauffement

    function initialize() {
        AppBase.initialize();
        System.println("RunQuestApp init");
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        view = new RunQuestView();
        delegate = new RunQuestDelegate();
        return [ view , delegate ];
    }

    function getAppView(){
        return view;
    }

    function getAppDelegate(){
        return delegate;
    }

}

function getApp() as RunQuestApp {
    return Application.getApp() as RunQuestApp;
}