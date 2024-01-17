import 'package:flutter/cupertino.dart';

/*ChangeNotifier is a simple class included in the Flutter SDK which provides change notification to its listeners.
In other words, if something is a ChangeNotifier, you can subscribe to its changes.
(It is a form of Observable, for those familiar with the term.)
* */

/// Provvider che si occupa di convidivere e aggiornare dati tra diversi componenti. In questo caso si occupa di condividere il CF tra future_operai e future_timbrature
/// Dashboard provvider si occupa di comunicare il Codice fiscale dell'operaio cliccato al future_timbrature, che ritornerà la lista delle timbrature eseguite da un codice fiscale.
///Serve per comunicare dati tra due componenti che si trovano nello stesso schermo
class DashboardProvider extends ChangeNotifier {
   String cfProvider = "";

  void changeCF(String cf) async {
    cfProvider = cf;

    /*This call tells the widgets that are listening to this model to rebuild.
    tells to the widget that is context.watch<DashboardProvider>().cfProvider; to rebuild.
     Call this method any time the model changes in a way that might change your app’s UI. */
    notifyListeners();
  }
}

