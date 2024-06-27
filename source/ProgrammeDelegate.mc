import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Timer;
import Toybox.Application;

class ProgrammeDelegate extends WatchUi.Menu2InputDelegate {
    var menuDelegate = getApp().getAppDelegate().getRunQuestMenuDelegate();

    function initialize() {
        Menu2InputDelegate.initialize();
        System.println("ProgrammeDelegate init");
    }

    //détecte quel item on sélectionne 
    function onSelect(item){
        if(item.getId().equals("Deb")){
            //met à jour l'icon en fonction du choix 
            menuDelegate.menuProg.getItem(0).setIcon(new Bitmap({:rezId=>Rez.Drawables.favori,:locX=>10,:locY=>30}));
            menuDelegate.menuProg.getItem(1).setIcon(new Bitmap({:rezId=>Rez.Drawables.Nfavori,:locX=>10,:locY=>30}));
            //on enregistre les params du programme choisit 
            Storage.setValue("echauffement", 10);
            Storage.setValue("tempsCircuit", 5);
            Storage.setValue("tempsPause", 3);
            //on enregistre que ce programme est choisit pour les prochaines fois 
            Storage.setValue("favori", 0);
        }else{
            menuDelegate.menuProg.getItem(0).setIcon(new Bitmap({:rezId=>Rez.Drawables.Nfavori,:locX=>10,:locY=>30}));
            menuDelegate.menuProg.getItem(1).setIcon(new Bitmap({:rezId=>Rez.Drawables.favori,:locX=>10,:locY=>30}));
            Storage.setValue("echauffement", 20);
            Storage.setValue("tempsCircuit", 10);
            Storage.setValue("tempsPause", 3);
            Storage.setValue("favori", 1);
        }
    }
    
}
