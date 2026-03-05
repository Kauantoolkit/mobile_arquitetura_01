import '../../domain/entities/product.dart';

/// Modelo de dados para Product com serialização/deserialização JSON.
/// Estende a entidade de domínio [Product] com capacidades da camada de dados.
class ProductModel extends Product {
  /// Cria um ProductModel com as propriedades informadas.
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
  });

  /// Cria um [ProductModel] a partir de um mapa JSON.
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
    );
  }

  /// Converte este [ProductModel] para um mapa JSON.
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'price': price, 'image': image};
  }

  /// Cria um [ProductModel] a partir de uma entidade de domínio [Product].
  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      title: product.title,
      price: product.price,
      image: product.image,
    );
  }

  /// Converte este modelo para uma entidade de domínio [Product].
  Product toEntity() {
    return Product(id: id, title: title, price: price, image: image);
  }
}

