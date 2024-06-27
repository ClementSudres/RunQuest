import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Timer;

class StatsDelegate extends WatchUi.BehaviorDelegate {

    var appView = getApp().getAppView();
    var appDelegate = getApp().getAppDelegate();

    var mainMenu = getApp().getAppDelegate().getMainMenu();
    var runQuestMenuDelegate = getApp().getAppDelegate().getRunQuestMenuDelegate();

    var keyPressTimer;
    var isKeyEscDown;
    var longPressTriggered;

    function initialize() {
        BehaviorDelegate.initialize();

        keyPressTimer = null;
        isKeyEscDown = false;
        longPressTriggered = false;
    }

    function onMenu() as Boolean {
        WatchUi.switchToView(new StatsView(), new RunQuestMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onStart() as Boolean {
        //WatchUi.switchToView(view, delegate, transition);
        return true; 
    }

    function onBack(){
        WatchUi.switchToView(mainMenu, runQuestMenuDelegate, WatchUi.SLIDE_DOWN); // ligne à commenter si la logique de retour au menu après un appuie long est décommenter
        return true;
    }
    /*
    function onKeyPressed(key) {
        var keyCode = key.getKey();
        if (keyCode == WatchUi.KEY_ESC) {
            handleKeyEscDown();
        }
        return true;
    }

    function onKeyReleased(key) {
        var keyCode = key.getKey();
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

    // Check ESC key press duration
    function checkKeyPressDuration() as Void {
        if (isKeyEscDown && !longPressTriggered) {
            longPressTriggered = true;
            forceHome();
        }
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
    function forceBack() {
        WatchUi.switchToView(mainMenu, runQuestMenuDelegate, WatchUi.SLIDE_DOWN);
    }

    // Force back to home view
    function forceHome() {
        WatchUi.switchToView(appView, appDelegate, WatchUi.SLIDE_UP);
    }
    */

}
