import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Attention;
import Toybox.Time;
import Toybox.Timer;

class RunWalkDelegate extends WatchUi.BehaviorDelegate {
    // Mes paramètres de course
    var chrono;
    var cycle;
    var tempsCircuit;
    var tempsPause;
    var timer;
    var pauseStartTime;

    // Le chrono défile ? 
    var enMarche = false;

    // Échauffement ou run ? 
    var echauffement = true;

    // Le programme est-il terminé ?
    var programmeFini = false;

    // On charge la vue 
    var view = getApp().getAppDelegate().getChronoView();
    var quizzDelegate;
    var quizzView;

    function initialize(echauffement, circuit, pause) {
        BehaviorDelegate.initialize();
        chrono = echauffement;
        tempsCircuit = circuit;
        tempsPause = pause;
        cycle = 4;
    }

    function onSelect() as Boolean {
        // Si le programme est terminé, retourner à l'accueil
        if (programmeFini) {
            returnToHome();
            return true;
        }

        // Vérifier si on est dans une période de pause
        if (getApp().periode == 2) {
            return true; // Ne rien faire si c'est une période de pause
        }

        // Ajouter des vibrations quand on lance la course ou met sur pause 
        if (System.getDeviceSettings().vibrateOn == true) {
            if (Attention has :vibrate) {
                var vibeData = [new Attention.VibeProfile(50, 1000)];
                Attention.vibrate(vibeData);
            }
        } else {
            WatchUi.showToast("vibrations off", null);
        }

        // Lancer l'échauffement ou le run walk et possibilité de mettre pause 
        if (echauffement == true) {
            if (enMarche == false) {
                enMarche = true;
                startEchauffement();
            } else {
                enMarche = false;
                pauseCountdown();
                view.circle_pause = true;
            }
        } else {
            if (enMarche == false) {
                enMarche = true;
                startCountdown();
                view.circle_pause = false;
            } else {
                enMarche = false;
                pauseCountdown();
                view.circle_pause = true;
            }
        }
        return true;
    }

    function startEchauffement() as Void {
        if (timer) {
            timer.start(method(:updateEchauffement), 1000, true);
            view.setMessage("Echauffement");
        } else {
            timer = new Timer.Timer();
            timer.start(method(:updateEchauffement), 1000, true);
            view.setMessage("Echauffement");
        }
    }

    function startCountdown() as Void {
        if (timer) {
            timer.start(method(:updateCountdown), 1000, true);
            if (cycle % 2 == 0) {
                view.setMessage("Pause");
                pauseStartTime = Time.now(); // Enregistrer le début de la pause
            } else {
                view.setMessage("Run");
            }
        } else {
            timer = new Timer.Timer();
            timer.start(method(:updateCountdown), 1000, true);
            if (cycle % 2 == 0) {
                view.setMessage("Pause");
                pauseStartTime = Time.now(); // Enregistrer le début de la pause
            } else {
                view.setMessage("Run");
            }
        }
    }

    function pauseCountdown() as Void {
        if (timer) {
            timer.stop();
        }
    }

    function updateEchauffement() as Void {
        // Lancer le quizz quand l'échauffement est fini
        if (chrono == 0) {
            timer.stop();
            view.setMessage("Quizz");
            cycle--;
            chrono = tempsCircuit;
            view.setTimer(chrono);

            echauffement = false;
            enMarche = false;
            getApp().chrono = chrono;
            getApp().periode = 1;

            quizzDelegate = new QuizzDelegate();
            quizzView = new QuizzView();
            WatchUi.switchToView(quizzView, quizzDelegate, WatchUi.SLIDE_DOWN);
        } else {
            chrono--;
            view.setTimer(chrono);
        }
    }

    function updateCountdown() as Void {
        if (chrono == 0) {
            cycle--;
            // Actions en fonction du cycle à venir 
            if (cycle == 0) {
                timer.stop();
                view.setMessage("Fin");
                view.message_draw = "Fin";
                getApp().chrono = 10;
                getApp().periode = 0;
                programmeFini = true; // Marquer le programme comme terminé
                view.arc_color = Graphics.COLOR_TRANSPARENT;
                view.circle_color = Graphics.COLOR_TRANSPARENT;
                //view.stopCircleAnimation();
            } else if (cycle % 2 == 0) {
                view.setMessage("Pause");
                view.message_draw = "Pause";
                chrono = tempsPause;
                view.setTimer(chrono);
                getApp().periode = 2;
                view.startCircleAnimation();
            } else {
                view.setMessage("Run");
                view.message_draw = "Run";
                chrono = tempsCircuit;
                view.setTimer(chrono);
                getApp().periode = 1;
                view.arc_color = Graphics.COLOR_TRANSPARENT;
                view.circle_color = Graphics.COLOR_TRANSPARENT;
                view.stopCircleAnimation();
            }
        } else {
            chrono--;
            view.setTimer(chrono);
        }
    }

    function returnToHome() as Void {
        WatchUi.switchToView(getApp().getAppView(), getApp().getAppDelegate(), WatchUi.SLIDE_DOWN);
    }

    function reset() as Void {
        pauseCountdown();
        chrono = getApp().chrono;
        cycle = 4;
        enMarche = false;
        echauffement = true;
        programmeFini = false;
        getApp().periode = 0;
        view.circle_pause = false;
        view.setMessage("");
        view.setTimer(chrono);
    }

    function getQuizzDelegate() {
        return quizzDelegate;
    }

    function getQuizzView() {
        return quizzView;
    }

    function onBack() {
        reset();
        returnToHome();
        return true;
    }
}
