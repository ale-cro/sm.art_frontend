///Classe che definisce la struttura di una Timbratura
///https://docs.flutter.dev/cookbook/networking/fetch-data
class Timbratura {
  final String idtimbratura;
  final String entrata;


  const Timbratura({
    required this.idtimbratura,
    required this.entrata,
  });
///Mapper fromJson to Timbratura
  factory Timbratura.fromJson(Map<String, dynamic> json) {
    return Timbratura(
      idtimbratura: json['idtimbratura'] as String,
      entrata: json['entrata'] as String,
    );
  }
}