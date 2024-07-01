import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Timer;
import Toybox.Math;

//gère les questions et les réponses du quizz 
class QuizzDelegate extends WatchUi.BehaviorDelegate {
    var chronoView = getApp().getAppDelegate().getChronoView();
    var chronoDelegate = getApp().getAppDelegate().getChronoDelegate();
    var random=0;

    //variable pour déterminer si on visualise la question ou les réponses 
    var requete = true; 

    //liste de 8 questions basiques pour tester 
    var questions = [
        ["Quel est le record du monde du 100 mètres masculin ?", 
        "A. 9.58 secondes", 
        "B. 9.63 secondes", 
        "C. 9.72 secondes", 
        "D. 9.74 secondes",
        "A"],
        
        ["Qui détient le record du monde du 200 mètres masculin ?", 
        "A. Michael Johnson", 
        "B. Yohan Blake", 
        "C. Tyson Gay", 
        "D. Usain Bolt",
        "D"],
        
        ["Combien de tours de piste fait-on pour un 1500 mètres ?", 
        "A. 3", 
        "B. 3.5", 
        "C. 3.75", 
        "D. 4",
        "C"],
        
        ["Quelle est la distance d'un marathon ?", 
        "A. 40.195 km", 
        "B. 41.195 km", 
        "C. 42.195 km", 
        "D. 43.195 km",
        "C"],
        
        ["Quel pays a remporté le relais 4x100 mètres masculin aux Jeux Olympiques de 2016 ?", 
        "A. États-Unis", 
        "B. Jamaïque", 
        "C. Canada", 
        "D. Grande-Bretagne",
        "B"],
        
        ["Quel est le record du monde du 800 mètres masculin ?", 
        "A. 1:40.91", 
        "B. 1:41.11", 
        "C. 1:41.51", 
        "D. 1:41.81",
        "A"],
        
        ["Qui détient le record du monde du 400 mètres haies féminin ?", 
        "A. Dalilah Muhammad", 
        "B. Sydney McLaughlin", 
        "C. Yuliya Pechonkina", 
        "D. Sally Gunnell",
        "B"],
        
        ["Combien de kilomètres font 10 miles ?", 
        "A. 15.1 km", 
        "B. 15.6 km", 
        "C. 16.1 km", 
        "D. 16.6 km",
        "C"]
    ];

    function initialize() {
        BehaviorDelegate.initialize();
        random = Math.rand()%7;
    }

    //si on clique sur down on sélectionne l'item en dessous
    //si on clique sur up on sélectionne l'item au dessus
    function onKey(key){
        if(key.getKey()==8){
            getApp().getAppDelegate().getChronoDelegate().getQuizzView().setChoix(1);
        }else if(key.getKey()==13){
            getApp().getAppDelegate().getChronoDelegate().getQuizzView().setChoix(-1);
        }
        return true; 
    }

    function onSelect() as Boolean {
        //si on visualise la question on passe à l'affichage des réponses 
        if(requete == true){
            getApp().getAppDelegate().getChronoDelegate().getQuizzView().setReponses();
            getApp().getAppDelegate().getChronoDelegate().getQuizzView().change=true;
            requete=false;
        //si on visualise les réponses on switch vers le run walk
        }else{
            if(getApp().getAppDelegate().getChronoDelegate().getQuizzView().choix==1 && questions[random][5].equals("A")){
                WatchUi.showToast("Vrai", null);
                WatchUi.switchToView(chronoView, chronoDelegate, WatchUi.SLIDE_DOWN);
            }else if(getApp().getAppDelegate().getChronoDelegate().getQuizzView().choix==2 && questions[random][5].equals("B")){
                WatchUi.showToast("Vrai", null);
                WatchUi.switchToView(chronoView, chronoDelegate, WatchUi.SLIDE_DOWN);
            }else if(getApp().getAppDelegate().getChronoDelegate().getQuizzView().choix==3 && questions[random][5].equals("C")){
                WatchUi.showToast("Vrai", null);
                WatchUi.switchToView(chronoView, chronoDelegate, WatchUi.SLIDE_DOWN);
            }else if(getApp().getAppDelegate().getChronoDelegate().getQuizzView().choix==4 && questions[random][5].equals("D")){
                WatchUi.showToast("Vrai", null);
                WatchUi.switchToView(chronoView, chronoDelegate, WatchUi.SLIDE_DOWN);
            }else{
                WatchUi.showToast("Faux", null);
                WatchUi.switchToView(chronoView, chronoDelegate, WatchUi.SLIDE_DOWN);
            }
        }
        return true; 
    }

    function onBack() {
        WatchUi.switchToView(getApp().getAppView(), getApp().getAppDelegate(), WatchUi.SLIDE_DOWN);
        return true;
    }
}
