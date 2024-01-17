import 'dart:convert';
import 'package:datatable_con_adaptive/dashboard/timbrature/timbratura.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

///Funzione per eseguire fetch dato un Cf
///https://docs.flutter.dev/cookbook/networking/fetch-data
Future<List<Timbratura>> fetchTimbratureFromCF(String cf) async {
  final response = await http.get(Uri.parse(
      'http://localhost:8080/demo/timbro/$cf'));
  await Future.delayed(const Duration(seconds: 1));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // Use the compute function to run parseUsers in a separate isolate.
    return compute(parseTimbratura, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User');
  }
}

List<Timbratura> parseTimbratura(String responseBody) {
  final parsed =
  (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();
  return parsed.map<Timbratura>((json) => Timbratura.fromJson(json)).toList();
}
