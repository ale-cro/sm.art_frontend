///Classe che definisce la struttura di un Operaio
class Utente {
  final int idutente;
  final String nome;
  final String password;
  final String email;

  const Utente({
    required this.idutente,
    required this.nome,
    required this.password,
    required this.email,
  });

  factory Utente.fromJson(Map<String, dynamic> parsedJson) {
      return Utente(
        idutente: parsedJson['idutente'] as int,
        nome: parsedJson['nome'] as String,
        password: parsedJson['password'] as String,
        email: parsedJson['email'] as String,
      );
  }
}