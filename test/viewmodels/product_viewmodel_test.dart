import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile_arquitetura_01/core/errors/failure.dart';
import 'package:mobile_arquitetura_01/domain/entities/product.dart';
import 'package:mobile_arquitetura_01/domain/repositories/product_repository.dart';
import 'package:mobile_arquitetura_01/presentation/viewmodels/product_viewmodel.dart';

// Mock class for ProductRepository
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late ProductViewModel viewModel;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    viewModel = ProductViewModel(repository: mockRepository);
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('ProductViewModel', () {
    final testProducts = [
      const Product(
        id: 1,
        title: 'Product 1',
        price: 10.0,
        image: 'http://example.com/1.jpg',
      ),
      const Product(
        id: 2,
        title: 'Product 2',
        price: 20.0,
        image: 'http://example.com/2.jpg',
      ),
    ];

    test('Initial state should have isLoading as false and empty products', () {
      // Assert
      expect(viewModel.state.value.isLoading, false);
      expect(viewModel.state.value.products, isEmpty);
      expect(viewModel.state.value.error, isNull);
    });

    test('loadProducts should update state to loading', () async {
      // Arrange
      when(
        () => mockRepository.getProducts(),
      ).thenAnswer((_) async => testProducts);

      // Act
      final future = viewModel.loadProducts();

      // Assert - state should be loading immediately
      expect(viewModel.state.value.isLoading, true);

      // Wait for completion
      await future;
    });

    test('loadProducts should return products on success', () async {
      // Arrange
      when(
        () => mockRepository.getProducts(),
      ).thenAnswer((_) async => testProducts);

      // Act
      await viewModel.loadProducts();

      // Assert
      expect(viewModel.state.value.isLoading, false);
      expect(viewModel.state.value.products, testProducts);
      expect(viewModel.state.value.error, isNull);
      verify(() => mockRepository.getProducts()).called(1);
    });

    test('loadProducts should handle Failure and update error state', () async {
      // Arrange
      when(
        () => mockRepository.getProducts(),
      ).thenThrow(const Failure('Network error'));

      // Act
      await viewModel.loadProducts();

      // Assert
      expect(viewModel.state.value.isLoading, false);
      expect(viewModel.state.value.products, isEmpty);
      expect(viewModel.state.value.error, 'Network error');
    });

    test(
      'loadProducts should handle generic exception and update error state',
      () async {
        // Arrange
        when(
          () => mockRepository.getProducts(),
        ).thenThrow(Exception('Unexpected error'));

        // Act
        await viewModel.loadProducts();

        // Assert
        expect(viewModel.state.value.isLoading, false);
        expect(viewModel.state.value.products, isEmpty);
        expect(
          viewModel.state.value.error,
          'Não foi possível carregar os produtos',
        );
      },
    );

    test('loadProducts should notify listeners on state change', () async {
      // Arrange
      var notificationCount = 0;
      viewModel.state.addListener(() {
        notificationCount++;
      });

      when(
        () => mockRepository.getProducts(),
      ).thenAnswer((_) async => testProducts);

      // Act
      await viewModel.loadProducts();

      // Assert - should notify at least twice: once for loading, once for success
      expect(notificationCount, greaterThanOrEqualTo(2));
    });
  });
}
