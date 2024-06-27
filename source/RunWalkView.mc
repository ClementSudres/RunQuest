import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class RunWalkView extends WatchUi.View {
    var timer;
    var message;
    var temps;

    function initialize(chrono) {
        View.initialize();

        temps=chrono;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.RunWalk(dc));

        timer = View.findDrawableById("Timer") as Text;
        message = View.findDrawableById("Message") as Text;
       
        setTimer(getApp().chrono);
        setMessage("Prêt ?");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        System.println("RunWalkView est visible");
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
        System.println("RunWalkView est masquée");
    }

    function setTimer(temps) as Void{
        var heures = temps / 3600;
        var minutes = (temps % 3600) / 60;
        var secondes = temps % 60;

        if(heures==0){
            // Formater les minutes et secondes avec deux chiffres
            var formattedTime = minutes.format("%02d") + ":" + secondes.format("%02d");
            timer.setText(formattedTime.toString());
        }else{
            // Formater les heures, minutes et secondes avec deux chiffres
            var formattedTime = heures.format("%02d") + ":" + minutes.format("%02d") + ":" + secondes.format("%02d");
            timer.setText(formattedTime.toString());
        }
        WatchUi.requestUpdate();
    }

    function setMessage(mess) as Void{
        message.setText(mess.toString());
        WatchUi.requestUpdate();
    }
}
