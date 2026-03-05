import '../entities/product.dart';

/// Interface abstrata do repositório para operações de dados de produtos.
/// Define o contrato para buscar produtos das fontes de dados.
abstract class ProductRepository {
  /// Busca a lista de todos os produtos.
  /// Retorna uma lista de entidades [Product].
  /// Lança [Failure] se a operação falhar.
  Future<List<Product>> getProducts();
}

