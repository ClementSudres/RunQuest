import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Timer;

class ProgrammeDelegate extends WatchUi.BehaviorDelegate {

    var appView = getApp().getAppView();
    var appDelegate = getApp().getAppDelegate();

    var mainMenu = getApp().getAppDelegate().getMainMenu();
    var runQuestMenuDelegate = getApp().getAppDelegate().getRunQuestMenuDelegate();

    var keyPressTimer;
    var isKeyEscDown;
    var keyCode;
    var longPressTriggered;

    function initialize() {
        BehaviorDelegate.initialize();
        System.println("ProgrammeDelegate init");

        keyPressTimer = null;
        isKeyEscDown = false;
        longPressTriggered = false;
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
        return true;
    }

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

}
