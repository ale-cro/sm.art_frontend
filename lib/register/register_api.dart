import 'dart:convert';
import 'package:datatable_con_adaptive/gestione_utenti/utente.dart';
import 'package:http/http.dart' as http;

///Funzioni per eseguire la registrazione e login di un utente
Future<Utente> registerUser(String nome, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/demo/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //Sets the content type so the application knows the payload cointains a JSON object.
    },
    body: jsonEncode(<String, String>{
      "nome": nome,
      "password": password,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Utente.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else if (response.statusCode == 400) {
    throw Exception('User già presente');
  } else {
    throw Exception('Dati non corretti');
  }
}

Future<Utente> loginUser(String nome, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/demo/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //Sets the content type so the application knows the payload cointains a JSON object.
    },
    body: jsonEncode(<String, String>{
      "nome": nome,
      "password": password,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Utente.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else if (response.statusCode == 400) {
    //in back end se non trova username 400 bad Request
    throw Exception('Username o password non corretti');
  } else {
    throw Exception('Dati non corretti');
  }
}

Future<Utente> changePassword(
    String nome, String password, String nuovaPass) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/demo/changePass'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //Sets the content type so the application knows the payload cointains a JSON object.
    },
    body: jsonEncode(<String, String>{
      "nome": nome,
      "password": password,
      "nuovaPassword": nuovaPass
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Utente.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else if (response.statusCode == 400) {
    throw Exception('Username o password non corretti');
  } else {
    throw Exception('Dati non corretti');
  }
}
