
import 'package:dart_either/dart_either.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/products_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repo.dart';

class GetProductByIdUseCase {
  final HomeRepo homeRepo;

  GetProductByIdUseCase(this.homeRepo);

  Future<Either<Failure, ProductsEntity>> invoke(int productId) =>
      homeRepo.getProductById(productId);
}