import 'package:datatable_con_adaptive/gestione_utenti/gestione_utenti_list.dart';
import 'package:datatable_con_adaptive/gestione_utenti/utente.dart';
import 'package:flutter/material.dart';

import 'gestione_utenti_api.dart';
///Classe che si occupa del fetch degli utenti per
class GestioneUtenti extends StatefulWidget {
  const GestioneUtenti({super.key});

  @override
  State<GestioneUtenti> createState() => _GestioneUtentiState();
}

class _GestioneUtentiState extends State<GestioneUtenti> {
  late Future<List<Utente>> userList;

  @override
  void initState() {
    super.initState();
    userList = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("gestione utenti"),
      ),
      body: FutureBuilder<List<Utente>>(
        //That is where FutureBuilder comes in. You can use it when you have a future, to display one thing while you are waiting for it (for example a progress indicator) and another thing when it's done (for example the result).
        future: userList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return UsersList(
              users: snapshot.data!,
            ); //Se il builder torna dei dati compatibili allora genero un nuovo UserList e popolo la lista user con i dati presenti nello snapshot
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
