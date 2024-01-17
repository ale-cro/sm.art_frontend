import 'package:flutter/material.dart';
import 'gestione_utenti_api.dart';

///Classe che definisce la schermata per modificare i dati dell'utente scelto.
///@param idUtente: Id dell'utente di cui si vogliono modificare i dati
class ModificaUtente extends StatefulWidget {
  const ModificaUtente({super.key, required this.idUtente});

  final int idUtente;

  @override
  _ModificaUtenteState createState() {
    return _ModificaUtenteState();
  }
}

class _ModificaUtenteState extends State<ModificaUtente> {
  late int idUtente;

  ///https://docs.flutter.dev/cookbook/forms/retrieve-input
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    idUtente = widget.idUtente;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("modifica utente"),
        ),
        body: Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextFormField(
          controller: nomeController,
          maxLength: 45,
          decoration: const InputDecoration(
            labelText: "inserisci nuovo nome",
            hintText: "nome",
          ),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        TextFormField(
          controller: passwordController,
          maxLength: 45,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          //più per mobile
          decoration: const InputDecoration(
            labelText: "inserisci nuova email",
            hintText: "email",
          ),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        TextFormField(
          controller: emailController,
          maxLength: 45,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          //più per mobile
          decoration: const InputDecoration(
            labelText: "inserisci la nuova password",
            hintText: "nuova password",
          ),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                modificaUtente(nomeController.text, passwordController.text,
                    emailController.text, idUtente);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ),
        Text("Idutente: $idUtente")
      ]),
    ));
  }
}
