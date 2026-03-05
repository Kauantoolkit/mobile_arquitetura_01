import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_arquitetura_01/data/models/product_model.dart';
import 'package:mobile_arquitetura_01/domain/entities/product.dart';

void main() {
  group('ProductModel', () {
    group('fromJson', () {
      test('should create ProductModel from valid JSON', () {
        // Arrange
        final json = {
          'id': 1,
          'title': 'Test Product',
          'price': 19.99,
          'image': 'http://example.com/image.jpg',
        };

        // Act
        final result = ProductModel.fromJson(json);

        // Assert
        expect(result.id, 1);
        expect(result.title, 'Test Product');
        expect(result.price, 19.99);
        expect(result.image, 'http://example.com/image.jpg');
      });

      test('should handle integer price', () {
        // Arrange
        final json = {
          'id': 1,
          'title': 'Test Product',
          'price': 20,
          'image': 'http://example.com/image.jpg',
        };

        // Act
        final result = ProductModel.fromJson(json);

        // Assert
        expect(result.price, 20.0);
      });

      test('should throw TypeError when JSON is null', () {
        // Arrange
        final Map<String, dynamic>? json = null;

        // Act & Assert - passing null to fromJson throws TypeError
        expect(
          () => ProductModel.fromJson(json!),
          throwsA(isA<TypeError>()),
        );
      });

      test('should throw FormatException when id is missing', () {
        // Arrange
        final json = {
          'title': 'Test Product',
          'price': 19.99,
          'image': 'http://example.com/image.jpg',
        };

        // Act & Assert
        expect(
          () => ProductModel.fromJson(json),
          throwsA(isA<FormatException>().having(
            (e) => e.message,
            'message',
            contains('id'),
          )),
        );
      });

      test('should throw FormatException when title is missing', () {
        // Arrange
        final json = {
          'id': 1,
          'price': 19.99,
          'image': 'http://example.com/image.jpg',
        };

        // Act & Assert
        expect(
          () => ProductModel.fromJson(json),
          throwsA(isA<FormatException>().having(
            (e) => e.message,
            'message',
            contains('title'),
          )),
        );
      });

      test('should throw FormatException when price is missing', () {
        // Arrange
        final json = {
          'id': 1,
          'title': 'Test Product',
          'image': 'http://example.com/image.jpg',
        };

        // Act & Assert
        expect(
          () => ProductModel.fromJson(json),
          throwsA(isA<FormatException>().having(
            (e) => e.message,
            'message',
            contains('price'),
          )),
        );
      });

      test('should throw FormatException when image is missing', () {
        // Arrange
        final json = {
          'id': 1,
          'title': 'Test Product',
          'price': 19.99,
        };

        // Act & Assert
        expect(
          () => ProductModel.fromJson(json),
          throwsA(isA<FormatException>().having(
            (e) => e.message,
            'message',
            contains('image'),
          )),
        );
      });

      test('should throw FormatException when id is not an integer', () {
        // Arrange
        final json = {
          'id': '1',
          'title': 'Test Product',
          'price': 19.99,
          'image': 'http://example.com/image.jpg',
        };

        // Act & Assert
        expect(
          () => ProductModel.fromJson(json),
          throwsA(isA<FormatException>().having(
            (e) => e.message,
            'message',
            contains('id'),
          )),
        );
      });

      test('should throw FormatException when title is not a string', () {
        // Arrange
        final json = {
          'id': 1,
          'title': 123,
          'price': 19.99,
          'image': 'http://example.com/image.jpg',
        };

        // Act & Assert
        expect(
          () => ProductModel.fromJson(json),
          throwsA(isA<FormatException>().having(
            (e) => e.message,
            'message',
            contains('title'),
          )),
        );
      });

      test('should throw FormatException when price is not a number', () {
        // Arrange
        final json = {
          'id': 1,
          'title': 'Test Product',
          'price': '19.99',
          'image': 'http://example.com/image.jpg',
        };

        // Act & Assert
        expect(
          () => ProductModel.fromJson(json),
          throwsA(isA<FormatException>().having(
            (e) => e.message,
            'message',
            contains('price'),
          )),
        );
      });

      test('should throw FormatException when image is not a string', () {
        // Arrange
        final json = {
          'id': 1,
          'title': 'Test Product',
          'price': 19.99,
          'image': 123,
        };

        // Act & Assert
        expect(
          () => ProductModel.fromJson(json),
          throwsA(isA<FormatException>().having(
            (e) => e.message,
            'message',
            contains('image'),
          )),
        );
      });
    });

    group('toJson', () {
      test('should convert ProductModel to JSON', () {
        // Arrange
        const model = ProductModel(
          id: 1,
          title: 'Test Product',
          price: 19.99,
          image: 'http://example.com/image.jpg',
        );

        // Act
        final result = model.toJson();

        // Assert
        expect(result['id'], 1);
        expect(result['title'], 'Test Product');
        expect(result['price'], 19.99);
        expect(result['image'], 'http://example.com/image.jpg');
      });
    });

    group('fromEntity', () {
      test('should create ProductModel from Product entity', () {
        // Arrange
        const entity = Product(
          id: 1,
          title: 'Test Product',
          price: 19.99,
          image: 'http://example.com/image.jpg',
        );

        // Act
        final result = ProductModel.fromEntity(entity);

        // Assert
        expect(result.id, 1);
        expect(result.title, 'Test Product');
        expect(result.price, 19.99);
        expect(result.image, 'http://example.com/image.jpg');
      });
    });

    group('toEntity', () {
      test('should convert ProductModel to Product entity', () {
        // Arrange
        const model = ProductModel(
          id: 1,
          title: 'Test Product',
          price: 19.99,
          image: 'http://example.com/image.jpg',
        );

        // Act
        final result = model.toEntity();

        // Assert
        expect(result.id, 1);
        expect(result.title, 'Test Product');
        expect(result.price, 19.99);
        expect(result.image, 'http://example.com/image.jpg');
      });
    });
  });
}

