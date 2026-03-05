import '../../domain/entities/product.dart';

/// Classe de estado representando o estado atual do carregamento de produtos.
class ProductState {
  /// Se os produtos estão sendo carregados atualmente.
  final bool isLoading;

  /// Lista de produtos carregados.
  final List<Product> products;

  /// Mensagem de erro se o carregamento falhou, null caso contrário.
  final String? error;

  /// Cria um ProductState com as propriedades informadas.
  /// Valores padrão são fornecidos para todos os campos.
  const ProductState({
    this.isLoading = false,
    this.products = const [],
    this.error,
  });

  /// Cria uma cópia deste estado com os campos informados substituídos.
  ProductState copyWith({
    bool? isLoading,
    List<Product>? products,
    String? error,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      error: error,
    );
  }
}

