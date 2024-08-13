import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../models/cart_model.dart';
import '../../../services/cart_service.dart';

part 'cart_quantity_state.dart';

class CartQuantityCubit extends Cubit<CartQuantityState> {
  CartQuantityCubit() : super(CartQuantityInitial());

  void increaseCart({
    required String userId,
    required String productId,
  }) async {
    emit(CartLoading());
    try {
      CartModel carts = await CartService().increaseQuantity(
        userId: userId,
        productId: productId,
      );

      emit(CartIncrease(carts));
    } on SocketException {
      emit(const CartError('No internet connection'));
    } on FirebaseException catch (e) {
      emit(CartError(e.message!));
    }
  }

  void decreaseCart({
    required String userId,
    required String productId,
  }) async {
    emit(CartLoading());
    try {
      CartModel carts = await CartService().decreaseQuantity(
        userId: userId,
        productId: productId,
      );

      emit(CartDecrease(carts));
    } on SocketException {
      emit(const CartError('No internet connection'));
    } on FirebaseException catch (e) {
      emit(CartError(e.message!));
    }
  }

  void deleteCart({
    required String userId,
    required String productId,
  }) async {
    emit(CartLoading());
    try {
      CartModel carts = await CartService().removeProduct(
        userId: userId,
        productId: productId,
      );

      emit(CartDelete(carts));
    } on SocketException {
      emit(const CartError('No internet connection'));
    } on FirebaseException catch (e) {
      emit(CartError(e.message!));
    }
  }
}
