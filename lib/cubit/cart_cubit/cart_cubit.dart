import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../models/cart_model.dart';
import '../../services/cart_service.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void addCart({
    required String userId,
    required String productId,
    required String size,
    required int quantity,
    required int price,
  }) async {
    emit(CartLoading());
    try {
      CartModel carts = await CartService().addToCart(
        userId: userId,
        productId: productId,
        size: size,
        quantity: quantity,
        price: price,
      );

      emit(CartSuccess(carts));
    } on SocketException {
      emit(const CartError('No internet connection'));
    } on FirebaseException catch (e) {
      emit(CartError(e.message!));
    }
  }

  void getCart(String userId) async {
    emit(CartLoading());
    try {
      CartModel carts = await CartService().getCart(userId);

      emit(CartLoaded(carts));
    } on SocketException {
      emit(const CartError('No internet connection'));
    } on FirebaseException catch (e) {
      emit(CartError(e.message!));
    }
  }
}
