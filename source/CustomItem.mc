import Toybox.Graphics;
import Toybox.WatchUi;

class CustomItem extends WatchUi.Drawable {
    var title;
    var bitmap;
    var pourcent;

    function initialize(titre, image, progress) {
        Drawable.initialize({
            :identifier=>:drawable,
            :locX=>0,
            :locY=>0,
            :width=>208,
            :height=>208,
            :visible=>true});
        title = titre;
        bitmap = image;
        pourcent = progress;
    }

    function draw(dc as Graphics.Dc) {
        dc.drawBitmap(10, 26, WatchUi.loadResource(bitmap));

        // Dessiner le texte du titre de l'élément de menu
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(110,40,Graphics.FONT_SMALL, title, Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(145,30,Graphics.FONT_XTINY, "0km", Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(200,30,Graphics.FONT_XTINY, "100", Graphics.TEXT_JUSTIFY_VCENTER);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        dc.drawRectangle(-20, 0, 250, 80);

        dc.drawRectangle(125, 39, 70, 8);
        dc.fillRectangle(125, 39, 70*pourcent, 8);
    }
}