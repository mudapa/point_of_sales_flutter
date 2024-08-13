part of 'cart_quantity_cubit.dart';

sealed class CartQuantityState extends Equatable {
  const CartQuantityState();

  @override
  List<Object> get props => [];
}

final class CartQuantityInitial extends CartQuantityState {}

final class CartLoading extends CartQuantityState {}

final class CartIncrease extends CartQuantityState {
  final CartModel carts;

  const CartIncrease(this.carts);

  @override
  List<Object> get props => [carts];
}

final class CartDecrease extends CartQuantityState {
  final CartModel carts;

  const CartDecrease(this.carts);

  @override
  List<Object> get props => [carts];
}

final class CartError extends CartQuantityState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}

final class CartDelete extends CartQuantityState {
  final CartModel carts;

  const CartDelete(this.carts);

  @override
  List<Object> get props => [carts];
}
