import '../models/product_model.dart';

/// Fonte de dados de cache em memória para produtos.
/// Fornece funcionalidade simples de cache para reduzir chamadas de rede.
class ProductCacheDatasource {
  /// Armazenamento interno para produtos em cache.
  List<ProductModel>? _cachedProducts;

  /// Salva a lista de produtos no cache.
  void save(List<ProductModel> products) {
    _cachedProducts = products;
  }

  /// Recupera os produtos em cache.
  /// Retorna null se nenhum produto estiver em cache.
  List<ProductModel>? get() {
    return _cachedProducts;
  }

  /// Limpa o cache.
  void clear() {
    _cachedProducts = null;
  }
}

