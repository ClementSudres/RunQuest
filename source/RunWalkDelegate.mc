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
    var quizzView;

    function initialize(echauffement, circuit, pause) {
        BehaviorDelegate.initialize();
        chrono = echauffement;
        tempsCircuit = circuit;
        tempsPause = pause;
        cycle = 4;
    }

    function onSelect() as Boolean {
        //ajouter des vibrations quand on lance la course ou met sur pause 
        if(System.getDeviceSettings().vibrateOn==true){
            if (Attention has :vibrate) {
                var vibeData =[new Attention.VibeProfile(50, 1000)];
                Attention.vibrate(vibeData);
            }
        }else{
            WatchUi.showToast("vibrations off", null);
        }   
        //lancer l'echauffement ou le run walk et possibilité de mettre pause 
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
            view.setMessage("Echauffement");
        }else{
            timer = new Timer.Timer();
            timer.start(method(:updateEchauffement), 1000, true);
            view.setMessage("Echauffement");
        }
    }

    function startCountdown() as Void{
        if(timer){
            timer.start(method(:updateCountdown), 1000, true);
            if(cycle%2==0){
                view.setMessage("Pause");
            }else{
                view.setMessage("Run");
            }
        }else{
            timer = new Timer.Timer();
            timer.start(method(:updateCountdown), 1000, true);
            if(cycle%2==0){
                view.setMessage("Pause");
            }else{
                view.setMessage("Run");
            }
        }
    }

    function pauseCountdown() as Void{
        timer.stop();
    }


    function updateEchauffement() as Void{
        //lancer le quizz quand l'echauffement est fini
        if(chrono==0){
            timer.stop();
            view.setMessage("Quizz");
            cycle--;
            chrono=tempsCircuit;
            view.setTimer(chrono);

            echauffement=false;
            enMarche = false;
            getApp().chrono = chrono;
            getApp().periode = 1;

            quizzDelegate = new QuizzDelegate();
            quizzView = new QuizzView();
            WatchUi.switchToView(quizzView, quizzDelegate, WatchUi.SLIDE_DOWN);
        }
        chrono--;
        view.setTimer(chrono);
    }

    function updateCountdown() as Void{
        if(chrono==0){
            cycle--;
            //actions en fonction du cycle à venir 
            if(cycle==0){
                timer.stop();
                view.setMessage("Fin");
                getApp().chrono=10;
                getApp().periode=0;
            }else if(cycle%2==0){
                view.setMessage("Pause");
                chrono=tempsPause;
                view.setTimer(chrono);
                getApp().periode=2;
            }else{
                view.setMessage("Run");
                chrono=tempsCircuit;
                view.setTimer(chrono);
                getApp().periode=1;
            }
        }
        view.setTimer(chrono);
        chrono--;
    }

    function getQuizzDelegate(){
        return quizzDelegate;
    }

    function getQuizzView(){
        return quizzView;
    }

    function onBack(){
        WatchUi.switchToView(getApp().getAppView(), getApp().getAppDelegate(), WatchUi.SLIDE_DOWN);
        return true;
    }

}