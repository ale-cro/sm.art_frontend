import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:datatable_con_adaptive/dashboard/operaio/operaio.dart';
import 'package:http/http.dart' as http;

/*Funzione per fare fetch degli operai paginati https://docs.flutter.dev/cookbook/networking/fetch-data
* Future is a core Dart class for working with asynchronous operations.
* A Future object represents a potential value or error that will be available at some time in the future.
* Future<T> returning the potential value which will be done by async work*/

Future<List<Operaio>> fetchPaging(int page, int size) async {
  final response = await http.get(Uri.parse(
      'http://localhost:8080/demo/param?page=$page&size=$size'));
  await Future.delayed(const Duration(seconds: 1));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // Use the compute function to run parseUsers in a separate isolate.
    print('Status Code fetch paging : ${response.statusCode}...');
    return compute(parseOperai, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User');
  }
}

List<Operaio> parseOperai(String responseBody) {
  final parsed =
  (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();
  return parsed.map<Operaio>((json) => Operaio.fromJson(json)).toList();
}

///Funzione per eseguire il POST di un Operaio
Future<Operaio> createOperaio(String cf, String nome) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/demo/add'),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8', //Sets the content type so the application knows the payload cointains a JSON object.
  },
    body: jsonEncode(<String, String>{
      "cf"  :  cf,
      "nome" : nome,
    }),
  );
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Operaio.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else if (response.statusCode == 400) {
    throw Exception('Operaio già presente');
  }else {
    throw Exception('Dati non corretti');
  }
}
