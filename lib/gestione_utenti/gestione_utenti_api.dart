import 'dart:convert';
import 'package:datatable_con_adaptive/gestione_utenti/utente.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Utente>> fetchUsers() async {
  final response =
      await http.get(Uri.parse('http://localhost:8080/demo/gestione_utenti'));
  //print(json.decode(response.body).toString());
  //print(response.toString());
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // Use the compute function to run parsePhotos in a separate isolate.

    return compute(parseUsers, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.

    throw Exception('Failed to load User');
  }
}

Future<Utente> modificaUtente(
    String nome, String password, String email, int idutente) async {
  final response = await http.put(
    Uri.parse('http://localhost:8080/demo/modifica_utente/$idutente'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //Sets the content type so the application knows the payload cointains a JSON object.
    },
    body: jsonEncode(<String, dynamic>{
      "idutente": idutente,
      "nome": nome,
      "password": password,
      "email": email,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Utente.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else if (response.statusCode == 400) {
    //nella mia back end se non trova username o la password dell'username è diversa allora caccio un 400 bad Request
    throw Exception('Username o password non corretti');
  } else {
    throw Exception('Dati non corretti');
  }
}

List<Utente> parseUsers(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();
  return parsed.map<Utente>((json) => Utente.fromJson(json)).toList();
}
