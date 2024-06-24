import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;
using Toybox.Time.Gregorian as Calendar;

class RunQuestView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        var clockTime = System.getClockTime();
        var heures = clockTime.hour.toString();
        var minutes = clockTime.min.format("%02d");
        var hour = View.findDrawableById("Heure") as Text;
        var min = View.findDrawableById("Minute") as Text;
        hour.setText(heures);
        min.setText(minutes);

        var now = Time.now();
        var time = Calendar.info(now, Time.FORMAT_MEDIUM);
        var dateString = Lang.format(
            "$1$ $2$",
            [
                time.day_of_week,
                time.day
            ]
        );
        var view3 = View.findDrawableById("Date") as Text;
        view3.setText(dateString);
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
