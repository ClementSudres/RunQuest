import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class QuizzView extends WatchUi.View {
    var quizzDelegate = getApp().getAppDelegate().getChronoDelegate().getQuizzDelegate();
    var quest; 

    var un;
    var deux;
    var trois;
    var quatre;
    var cinq;
    var six;
    var sept;
    var huit;
    var neuf;

    var choix = 1;
    var change = false;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.Quizz(dc));

        quest = quizzDelegate.random;

        un = findDrawableById("un");
        deux = findDrawableById("deux");
        trois = findDrawableById("trois");
        quatre = findDrawableById("quatre");
        cinq = findDrawableById("cinq");
        six = findDrawableById("six");
        sept = findDrawableById("sept");
        huit = findDrawableById("huit");
        neuf = findDrawableById("neuf");

        setQuestions();
    }

    function setQuestions(){
        var temp = quizzDelegate.questions[quest][0];
        var longueur = temp.length();
        var j = 0;
        for(var i = 0; i < 9; i++){
            if(longueur<18){
                break;
            }else{
                j++;
                longueur = longueur/2;
            }
        }
        longueur = temp.length();
        if(j==0){
            quatre.setText(quizzDelegate.questions[quest][0]);
        }else if(j==1){
            quatre.setText(temp.substring(0,(longueur)/2));
            cinq.setText(temp.substring((longueur)/2,longueur));
        }else if(j==2){
            trois.setText(temp.substring(0,(longueur)/3));
            quatre.setText(temp.substring((longueur)/3,(2*(longueur))/3));
            cinq.setText(temp.substring((2*(longueur))/3, longueur));
        }else if(j==3){
            trois.setText(temp.substring(0,(longueur)/4));
            quatre.setText(temp.substring((longueur)/4,(2*(longueur))/4));
            cinq.setText(temp.substring((2*(longueur))/4, (3*(longueur))/4));
            six.setText(temp.substring((3*(longueur))/4, longueur));
        }else if(j==4){
            trois.setText(temp.substring(0,(longueur)/5));
            quatre.setText(temp.substring((longueur)/5,(2*(longueur))/5));
            cinq.setText(temp.substring((2*(longueur))/5,(3*(longueur))/5));
            six.setText(temp.substring((3*(longueur))/5,(4*(longueur))/5));
            sept.setText(temp.substring((4*(longueur))/5, longueur));
        }else if(j==5){
            deux.setText(temp.substring(0,(longueur)/6));
            trois.setText(temp.substring((longueur)/6,(2*(longueur))/6));
            quatre.setText(temp.substring((2*(longueur))/6,(3*(longueur))/6));
            cinq.setText(temp.substring((3*(longueur))/6,(4*(longueur))/6));
            six.setText(temp.substring((4*(longueur))/6,(5*(longueur))/6));
            sept.setText(temp.substring((5*(longueur))/6,longueur));
        }else if(j==6){
            deux.setText(temp.substring(0,(longueur)/7));
            trois.setText(temp.substring((longueur)/7,(2*(longueur))/7));
            quatre.setText(temp.substring((2*(longueur))/7,(3*(longueur))/7));
            cinq.setText(temp.substring((3*(longueur))/7,(4*(longueur))/7));
            six.setText(temp.substring((4*(longueur))/7,(5*(longueur))/7));
            sept.setText(temp.substring((5*(longueur))/7,(6*(longueur))/7));
            huit.setText(temp.substring((6*(longueur))/7,longueur));
        }else if(j==7){
            un.setText(temp.substring(0,(longueur)/8));
            deux.setText(temp.substring((longueur)/8,(2*(longueur))/8));
            trois.setText(temp.substring((2*(longueur))/8,(3*(longueur))/8));
            quatre.setText(temp.substring((3*(longueur))/8,(4*(longueur))/8));
            cinq.setText(temp.substring((4*(longueur))/8,(5*(longueur))/8));
            six.setText(temp.substring((5*(longueur))/8,(6*(longueur))/8));
            sept.setText(temp.substring((6*(longueur))/8,(7*(longueur))/8));
            huit.setText(temp.substring((7*(longueur))/8,longueur));
        }else if(j==8){
            un.setText(temp.substring(0,(longueur)/9));
            deux.setText(temp.substring((longueur)/9,(2*(longueur))/9));
            trois.setText(temp.substring((2*(longueur))/9,(3*(longueur))/9));
            quatre.setText(temp.substring((3*(longueur))/9,(4*(longueur))/9));
            cinq.setText(temp.substring((4*(longueur))/9,(5*(longueur))/9));
            six.setText(temp.substring((5*(longueur))/9,(6*(longueur))/9));
            sept.setText(temp.substring((6*(longueur))/9,(7*(longueur))/9));
            huit.setText(temp.substring((7*(longueur))/9,(8*(longueur))/9));
            neuf.setText(temp.substring((8*(longueur))/9,longueur));
        }
    }

    function setReponses() as Void{
        trois.setText(quizzDelegate.questions[quest][1]);
        quatre.setText(quizzDelegate.questions[quest][2]);
        cinq.setText(quizzDelegate.questions[quest][3]);
        six.setText(quizzDelegate.questions[quest][4]);

        un.setText("");
        deux.setText("");
        sept.setText("");
        huit.setText("");
        neuf.setText("");

        WatchUi.requestUpdate();
    }

    function setChoix(val){
        System.println(val);
        if(choix==1 && val == -1){
            choix=4;
        }else if(choix==4 && val==1){
            choix=1;
        }else{
            choix = choix + val;
        }
        WatchUi.requestUpdate();
    }
    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        if(change==true){
            if(choix==1){
                dc.clear();
                dc.drawRectangle(0, 65, 300, 20);
            }else if(choix==2){
                dc.clear();
                dc.drawRectangle(0, 85, 300, 20);
            }else if(choix==3){
                dc.clear();
                dc.drawRectangle(0, 105, 300, 20);
            }else if(choix==4){
                dc.clear();
                dc.drawRectangle(0, 125, 300, 20);
            }
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
