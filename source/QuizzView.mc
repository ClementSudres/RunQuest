import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class QuizzView extends WatchUi.View {
    var quizzDelegate = getApp().getAppDelegate().getChronoDelegate().getQuizzDelegate();
    var quest; 
    var qe;
    var un;
    var deux;
    var trois;
    var quatre;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.Quizz(dc));

        quest = quizzDelegate.random;
        qe = View.findDrawableById("Question") as Text;
        un = View.findDrawableById("A") as Text;
        deux = View.findDrawableById("B") as Text;
        trois = View.findDrawableById("C") as Text;
        quatre = View.findDrawableById("D") as Text;

        setQuestions();
    }

    function setQuestions(){
        qe.setText(quizzDelegate.questions[quest][0]);
        un.setText(quizzDelegate.questions[quest][1]);
        deux.setText(quizzDelegate.questions[quest][2]);
        trois.setText(quizzDelegate.questions[quest][3]);
        quatre.setText(quizzDelegate.questions[quest][4]);
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
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
