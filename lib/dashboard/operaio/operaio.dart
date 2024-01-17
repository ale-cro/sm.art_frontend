///Classe che definisce la struttura di un Operaio
///https://docs.flutter.dev/cookbook/networking/fetch-data
class Operaio {
  final String cf;
  final String nome;

  const Operaio({
    required this.cf,
    required this.nome,
  });

  ///Mapper fromJson to Operaio
  factory Operaio.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'cf': String cf,
      'nome': String nome,
      } =>
          Operaio (
            cf: cf,
            nome: nome,
          ),
      _ => throw const FormatException('Failed to load Operaio.'),
    };
  }
}