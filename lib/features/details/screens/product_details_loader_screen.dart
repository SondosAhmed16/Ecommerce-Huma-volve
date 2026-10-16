import 'package:dart_either/dart_either.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/products_entity.dart';
import 'package:flutter/material.dart';

import 'product_details_screen.dart';

class ProductDetailsLoaderScreen extends StatelessWidget {
  final Future<Either<Failure, ProductsEntity>> productFuture;

  const ProductDetailsLoaderScreen({super.key, required this.productFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<Failure, ProductsEntity>>(
      future: productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return _ProductLoadError(
            message: 'Could not load this product. Please try again.',
          );
        }

        return snapshot.data!.fold(
          ifLeft: (failure) => _ProductLoadError(message: failure.message),
          ifRight: (product) => ProductDetailsScreen(product: product),
        );
      },
    );
  }
}

class _ProductLoadError extends StatelessWidget {
  final String message;

  const _ProductLoadError({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(message, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
