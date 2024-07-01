import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;
import Toybox.Application;
import Toybox.Timer;
import Toybox.Time;

class RunWalkView extends WatchUi.View {

    var timer;
    var message;
    var temps;
    var circleSize = 0;
    var isGrowing = true;
    var animationTimer;
    var animationStartTime;
    var animationDuration = 90000; // 1 minute 30 seconds

    var timer_draw;
    var message_draw;
    var arc_color;
    var circle_color;
    var circle_pause;

    var vibeData = [new Attention.VibeProfile(50, 1000)];

    function initialize(chrono) {
        View.initialize();
        temps = chrono;
        timer_draw = "00:00";
        message_draw = "";
        arc_color = Graphics.COLOR_TRANSPARENT;
        circle_color = Graphics.COLOR_TRANSPARENT;
        circle_pause = false;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.RunWalk(dc));
        // Paramétrer l'écran initial du run walk
        timer = View.findDrawableById("Timer") as Text;
        message = View.findDrawableById("Message") as Text;
        if(Storage.getValue("echauffement") != null){
            if(getApp().periode == 0){
                setTimer(Storage.getValue("echauffement"));
            } else if(getApp().periode == 1){
                setTimer(Storage.getValue("tempsCircuit"));
            } else if(getApp().periode == 2){
                setTimer(Storage.getValue("tempsPause"));
            }
        } else {
            setTimer(getApp().chrono);
        }
        setMessage("Prêt ?");
    }

    // Called when this View is brought to the foreground
    function onShow() as Void {
        System.println("RunWalkView est visible");
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Dessiner les éléments de la mise en page par-dessus le cercle
        View.onUpdate(dc);

        // Dessiner le cercle
        dc.setColor(circle_color, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(dc.getWidth() / 2, dc.getHeight() / 2, circleSize);

        // Dessine le texte du timer
        dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2, 15 , Graphics.FONT_NUMBER_THAI_HOT, timer_draw, Graphics.TEXT_JUSTIFY_CENTER);

        // Dessine le texte du message
        dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2, 15 , Graphics.FONT_SMALL, message_draw, Graphics.TEXT_JUSTIFY_CENTER);

        //Dessine le temoin pour la respiration
        dc.setPenWidth(1);
        dc.setColor(arc_color, Graphics.COLOR_BLACK);
        dc.drawArc(dc.getWidth()/2, dc.getWidth()/2, 91, Graphics.ARC_CLOCKWISE, 90, 90);

        // Forcer la mise à jour de l'affichage
        WatchUi.requestUpdate();
    }

    // Called when this View is removed from the screen
    function onHide() as Void {
        System.println("RunWalkView est masquée");
        stopCircleAnimation();
    }

    // Functions to update the display
    function setTimer(temps) as Void {
        var heures = temps / 3600;
        var minutes = (temps % 3600) / 60;
        var secondes = temps % 60;

        if(heures == 0){
            // Format minutes and seconds with two digits
            var formattedTime = minutes.format("%02d") + ":" + secondes.format("%02d");
            timer.setText(formattedTime.toString());
            timer_draw = formattedTime.toString();
        } else {
            // Format hours, minutes, and seconds with two digits
            var formattedTime = heures.format("%02d") + ":" + minutes.format("%02d") + ":" + secondes.format("%02d");
            timer.setText(formattedTime.toString());
            timer_draw = formattedTime.toString();
        }
        WatchUi.requestUpdate();
    }

    function setMessage(mess) as Void {
        message.setText(mess.toString());
        WatchUi.requestUpdate();
    }

    function startCircleAnimation() as Void {
        timer.setText("");
        System.println("Started");
        arc_color = Graphics.COLOR_GREEN;
        circle_color = Graphics.COLOR_BLUE;
        circleSize = 20;
        isGrowing = true;
        animationStartTime = Time.now();
        if (animationTimer == null) {
            animationTimer = new Timer.Timer();
        }
        animationTimer.start(method(:updateCircleAnimation), 50, true);
        WatchUi.requestUpdate();
    }

    function updateCircleAnimation() as Void {
        if(!circle_pause){
            if (isGrowing) {
                circleSize += 0.7;
                if (circleSize >= 90) { // Max size
                    isGrowing = false;
                    Attention.vibrate(vibeData);
                }
            } else {
                circleSize -= 0.7;
                if (circleSize <= 20) { // Min size
                    isGrowing = true;
                    Attention.vibrate(vibeData);
                }
            }
            WatchUi.requestUpdate();
        }
    }

    function stopCircleAnimation() as Void {
        if (animationTimer != null) {
            animationTimer.stop();
            animationTimer = null;
        }
        circleSize = 0;
        arc_color = Graphics.COLOR_TRANSPARENT;
        circle_color = Graphics.COLOR_TRANSPARENT;
        WatchUi.requestUpdate();
    }

}
