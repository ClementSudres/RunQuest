import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Attention;

class RunWalkDelegate extends WatchUi.BehaviorDelegate {
    //mes paramètres de course
    var chrono;
    var cycle;
    var tempsCircuit;
    var tempsPause;
    var timer;

    //le chrono défile ? 
    var enMarche = false;

    //echauffement ou run ? 
    var echauffement = true;

    //on charge la vue 
    var view = getApp().getAppDelegate().getChronoView();
    var quizzDelegate;

    function initialize(echauffement, circuit, pause) {
        BehaviorDelegate.initialize();
        chrono = echauffement;
        tempsCircuit = circuit;
        tempsPause = pause;
        cycle = 4;
    }

    function onSelect() as Boolean {
        if(System.getDeviceSettings().vibrateOn==true){
            if (Attention has :vibrate) {
                var vibeData =[new Attention.VibeProfile(50, 1000)];
                Attention.vibrate(vibeData);
            }
        }else{
            WatchUi.showToast("vibrations off", null);
        }   

        if(echauffement==true){
            if(enMarche==false){
                enMarche = true;
                startEchauffement();
            }else{
                enMarche = false;
                pauseCountdown();
            }
        }else{
            if(enMarche==false){
                enMarche = true;
                startCountdown();
            }else{
                enMarche = false;
                pauseCountdown();
            }
        }
        return true;
    }

    function startEchauffement() as Void{
        if(timer){
            timer.start(method(:updateEchauffement), 1000, true);
        }else{
            timer = new Timer.Timer();
            timer.start(method(:updateEchauffement), 1000, true);
        }
    }

    function startCountdown() as Void{
        if(timer){
            timer.start(method(:updateCountdown), 1000, true);
        }else{
            timer = new Timer.Timer();
            timer.start(method(:updateCountdown), 1000, true);
        }
    }

    function pauseCountdown() as Void{
        timer.stop();
    }


    function updateEchauffement() as Void{
        if(chrono==0){
            timer.stop();
            view.setMessage("Quizz");
            cycle--;
            chrono=tempsCircuit;
            view.setTimer(chrono);
            echauffement=false;
            enMarche = false;

            quizzDelegate = new QuizzDelegate();
            WatchUi.switchToView(new QuizzView(), quizzDelegate, WatchUi.SLIDE_DOWN);
        }
        chrono--;
        view.setTimer(chrono);
    }

    function updateCountdown() as Void{
        if(chrono==0){
            if(cycle==0){
                timer.stop();
                view.setMessage("Fin");
            }else if(cycle%2==0){
                view.setMessage("Pause");
                chrono=tempsPause;
                view.setTimer(chrono);
                cycle--;
            }else{
                view.setMessage("Run");
                chrono=tempsCircuit;
                view.setTimer(chrono);
                cycle--;
            }
        }
        view.setTimer(chrono);
        chrono--;
    }

    function getQuizzDelegate(){
        return quizzDelegate;
    }

    function onBack(){
        WatchUi.switchToView(getApp().getAppView(), getApp().getAppDelegate(), WatchUi.SLIDE_DOWN);
        return true;
    }

}