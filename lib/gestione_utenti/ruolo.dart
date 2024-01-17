///Classe che definisce la struttura di un Ruolo
class Ruolo {
  final String nome;

  const Ruolo({
    required this.nome,
  });

  factory Ruolo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'nome': String nome,
      } =>
          Ruolo (
            nome: nome,
          ),
      _ => throw const FormatException('Failed to load Ruolo.'),
    };
  }
}