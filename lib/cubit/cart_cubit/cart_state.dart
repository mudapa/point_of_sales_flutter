part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final CartModel carts;

  const CartSuccess(this.carts);

  @override
  List<Object> get props => [carts];
}

final class CartLoaded extends CartState {
  final CartModel carts;

  const CartLoaded(this.carts);

  @override
  List<Object> get props => [carts];
}

final class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}
