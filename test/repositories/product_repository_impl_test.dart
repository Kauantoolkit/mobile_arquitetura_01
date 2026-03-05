import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile_arquitetura_01/core/errors/failure.dart';
import 'package:mobile_arquitetura_01/data/datasources/product_remote_datasource.dart';
import 'package:mobile_arquitetura_01/data/datasources/product_cache_datasource.dart';
import 'package:mobile_arquitetura_01/data/models/product_model.dart';
import 'package:mobile_arquitetura_01/data/repositories/product_repository_impl.dart';
import 'package:mobile_arquitetura_01/domain/entities/product.dart';

// Mock classes
class MockProductRemoteDatasource extends Mock implements ProductRemoteDatasource {}

class MockProductCacheDatasource extends Mock implements ProductCacheDatasource {}

// Register fallback values for mocktail
class FakeProductModel extends Fake implements ProductModel {}

void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDatasource mockRemoteDatasource;
  late MockProductCacheDatasource mockCacheDatasource;

  setUpAll(() {
    registerFallbackValue(FakeProductModel());
  });

  setUp(() {
    mockRemoteDatasource = MockProductRemoteDatasource();
    mockCacheDatasource = MockProductCacheDatasource();
    repository = ProductRepositoryImpl(
      remoteDatasource: mockRemoteDatasource,
      cacheDatasource: mockCacheDatasource,
    );
  });

  group('ProductRepositoryImpl', () {
    final testProductModels = [
      const ProductModel(id: 1, title: 'Product 1', price: 10.0, image: 'http://example.com/1.jpg'),
      const ProductModel(id: 2, title: 'Product 2', price: 20.0, image: 'http://example.com/2.jpg'),
    ];

    final testProducts = [
      const Product(id: 1, title: 'Product 1', price: 10.0, image: 'http://example.com/1.jpg'),
      const Product(id: 2, title: 'Product 2', price: 20.0, image: 'http://example.com/2.jpg'),
    ];

    group('getProducts', () {
      test('should return products from remote datasource when successful', () async {
        // Arrange
        when(() => mockRemoteDatasource.getProducts()).thenAnswer(
          (_) async => testProductModels,
        );
        when(() => mockCacheDatasource.save(any())).thenReturn(null);

        // Act
        final result = await repository.getProducts();

        // Assert
        expect(result, testProducts);
        verify(() => mockRemoteDatasource.getProducts()).called(1);
        verify(() => mockCacheDatasource.save(testProductModels)).called(1);
      });

      test('should return products from cache when remote fails with cached data', () async {
        // Arrange
        when(() => mockRemoteDatasource.getProducts()).thenThrow(
          const Failure('Network error'),
        );
        when(() => mockCacheDatasource.get()).thenReturn(testProductModels);

        // Act
        final result = await repository.getProducts();

        // Assert
        expect(result, testProducts);
        verify(() => mockRemoteDatasource.getProducts()).called(1);
        verify(() => mockCacheDatasource.get()).called(1);
      });

      test('should throw Failure when remote fails and cache is empty', () async {
        // Arrange
        when(() => mockRemoteDatasource.getProducts()).thenThrow(
          const Failure('Network error'),
        );
        when(() => mockCacheDatasource.get()).thenReturn(null);

        // Act & Assert
        expect(
          () => repository.getProducts(),
          throwsA(isA<Failure>()),
        );
      });

      test('should return products from cache when remote throws generic exception', () async {
        // Arrange
        when(() => mockRemoteDatasource.getProducts()).thenThrow(
          Exception('Unknown error'),
        );
        when(() => mockCacheDatasource.get()).thenReturn(testProductModels);

        // Act
        final result = await repository.getProducts();

        // Assert
        expect(result, testProducts);
      });

      test('should throw Failure when both remote and cache fail', () async {
        // Arrange
        when(() => mockRemoteDatasource.getProducts()).thenThrow(
          Exception('Unknown error'),
        );
        when(() => mockCacheDatasource.get()).thenReturn(null);

        // Act & Assert
        expect(
          () => repository.getProducts(),
          throwsA(isA<Failure>()),
        );
      });

      test('should save products to cache after successful remote fetch', () async {
        // Arrange
        when(() => mockRemoteDatasource.getProducts()).thenAnswer(
          (_) async => testProductModels,
        );
        when(() => mockCacheDatasource.save(any())).thenReturn(null);

        // Act
        await repository.getProducts();

        // Assert
        verify(() => mockCacheDatasource.save(testProductModels)).called(1);
      });
    });
  });
}

