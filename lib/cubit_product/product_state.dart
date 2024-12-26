part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}


final class ProductLoading extends ProductState {}


final class ProductLoaded extends ProductState {
    final List<ProductModel> product;
    ProductLoaded(this.product);
}
final class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}





