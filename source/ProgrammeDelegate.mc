import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Timer;
import Toybox.Application;

class ProgrammeDelegate extends WatchUi.Menu2InputDelegate {

    var appView = getApp().getAppView();
    var appDelegate = getApp().getAppDelegate();

    var mainMenu = getApp().getAppDelegate().getMainMenu();
    var runQuestMenuDelegate = getApp().getAppDelegate().getRunQuestMenuDelegate();

    //var keyPressTimer;
    //var isKeyEscDown;
    //var keyCode;
    //var longPressTriggered;

    function initialize() {
        Menu2InputDelegate.initialize();
        System.println("ProgrammeDelegate init");

        //keyPressTimer = null;
        //isKeyEscDown = false;
        //longPressTriggered = false;
    }

    function onMenu() as Boolean {
        WatchUi.switchToView(mainMenu, runQuestMenuDelegate, WatchUi.SLIDE_UP);
        return true;
    }

    function onStart() as Boolean {
        //WatchUi.switchToView(view, delegate, transition);
        return true; 
    }

    function onBack(){
        WatchUi.switchToView(mainMenu, runQuestMenuDelegate, WatchUi.SLIDE_DOWN); // ligne à commenter si la logique de retour au menu après un appuie long est décommenter
    }

    //détecte quel item on sélectionne 
    function onSelect(item){
        if(item.getId().equals("Deb")){
            //met à jour l'icon en fonction du choix 
            runQuestMenuDelegate.menuProg.getItem(0).setIcon(new Bitmap({:rezId=>Rez.Drawables.favori,:locX=>10,:locY=>30}));
            runQuestMenuDelegate.menuProg.getItem(1).setIcon(new Bitmap({:rezId=>Rez.Drawables.Nfavori,:locX=>10,:locY=>30}));
            //on enregistre les params du programme choisit 
            Storage.setValue("echauffement", 10);
            Storage.setValue("tempsCircuit", 5);
            Storage.setValue("tempsPause", 3);
            //on enregistre que ce programme est choisit pour les prochaines fois 
            Storage.setValue("favori", 0);
        }else{
            runQuestMenuDelegate.menuProg.getItem(0).setIcon(new Bitmap({:rezId=>Rez.Drawables.Nfavori,:locX=>10,:locY=>30}));
            runQuestMenuDelegate.menuProg.getItem(1).setIcon(new Bitmap({:rezId=>Rez.Drawables.favori,:locX=>10,:locY=>30}));
            Storage.setValue("echauffement", 20);
            Storage.setValue("tempsCircuit", 10);
            Storage.setValue("tempsPause", 3);
            Storage.setValue("favori", 1);
        }
    }

    /*
    function onKeyPressed(key){
        keyCode = key.getKey();
        if (keyCode == WatchUi.KEY_ESC) {
            handleKeyEscDown();
        }
        return true;
    }

    // Check ESC key press duration
    function checkKeyPressDuration() as Void {
        if (isKeyEscDown && !longPressTriggered) {
            longPressTriggered = true;
            forceHome();
        }
    }

    // Handle key release events
    function onKeyReleased(key) {
        keyCode = key.getKey();
        if (keyCode == WatchUi.KEY_ESC) {
            handleKeyEscUp();
        }
        return true;
    }

    // Handle ESC key down
    function handleKeyEscDown() {
        isKeyEscDown = true;
        longPressTriggered = false;
        startKeyPressTimer();
    }

    // Handle ESC key up
    function handleKeyEscUp() {
        if (!longPressTriggered) {
            forceBack();
        }
        isKeyEscDown = false;
        stopKeyPressTimer();
    }

    // Start key press timer
    function startKeyPressTimer() {
        if (keyPressTimer == null) {
            keyPressTimer = new Timer.Timer();
            keyPressTimer.start(method(:checkKeyPressDuration), 1000, false); // Vérifie après 1 seconde
        }
    }

    // Stop key press timer
    function stopKeyPressTimer() {
        if (keyPressTimer != null) {
            keyPressTimer.stop();
            keyPressTimer = null;
        }
    }

    // Force back to main menu
    function forceBack(){
        WatchUi.switchToView(mainMenu, runQuestMenuDelegate, WatchUi.SLIDE_DOWN);
    }

    // Force back to home view
    function forceHome(){
        WatchUi.switchToView(appView, appDelegate, WatchUi.SLIDE_UP);
    }
    */
    
}
