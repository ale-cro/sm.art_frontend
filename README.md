# datatable_con_adaptive

Frontend applicativo.

Homepage : Contiene due layout, un per desktop e uno per Mobile, riducendo la larghezza dello schermo 

DashBoard : Esegue fecth degli Operai impaginati (come valore di default vengono caricati 20 operai alla volta), eseguendo lo scroll verso il basso viene eseguito lazy loading di altri operai. Eseguendo click su un elemento della lista degli Operai vengono caricate anche le timbrature associate ad ogni operaio. In modalità Desktop vengono visualizzate sia la lista degli operai che la lista delle timbrature sulla stessa finesta. In modalità mobile, quando viene eseguito click viene fatta vedere la schermata dedicata alle timbrature. Quando si esegue onLongPress su un record Intero della lista viene fatta vedere una schermata Cupertino (iOS).

Register : Registra un nuovo Utente (username e password) 

Login : Controlla se la coppia utente e password è presente.

Change pasword : Modificare la password di un Utente registrato, per eseguire modifica bisogna inserire un username e la vecchia password associata all'usrname

Gestione Utenti : Carica tabella dove vengono visualizzati tutti gli utenti registrati con i dati associati.

## Eseguire Applicativo
Selezionare come dispositivo chrome o edge.
Scegliere main.dart 
Cliccare freccia verde

su Intellij cliccare New -> Project from version control ed inserire il link del repo.
Una volta clonato il progetto eseguire pub get per aggiungere tutte le depencies richieste.


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
