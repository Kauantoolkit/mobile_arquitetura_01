/// Classe de exceção que representa falhas na aplicação.
/// Usada para envolver erros da camada de dados e propagá-los para a apresentação.
class Failure implements Exception {
  /// A mensagem de erro descrevendo o que deu errado.
  final String message;

  /// Cria um Failure com a mensagem informada.
  const Failure(this.message);

  @override
  String toString() => 'Failure: $message';
}

