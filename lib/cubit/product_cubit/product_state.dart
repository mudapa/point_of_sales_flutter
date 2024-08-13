part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ListProductLoaded extends ProductState {
  final List<ProductModel> products;

  const ListProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class ProductLoaded extends ProductState {
  final ProductModel product;

  const ProductLoaded(this.product);

  @override
  List<Object> get props => [product];
}

final class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
