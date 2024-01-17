import 'package:flutter/material.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  ChangePasswordFormState createState() {
    return ChangePasswordFormState();
  }
}

class ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextFormField(
          controller: nomeController,
          maxLength: 45,
          decoration: const InputDecoration(
            labelText: "inserisci nome",
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
            labelText: "inserisci password",
            hintText: "password",
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
          controller: newPasswordController,
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

                //changePassword(nomeController.text, passwordController.text, newPasswordController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ),
      ]),
    ));
  }
}
