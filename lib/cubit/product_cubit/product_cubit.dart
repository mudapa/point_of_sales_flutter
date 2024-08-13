import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../models/product_model.dart';
import '../../services/product_service.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  void getProducts() async {
    emit(ProductLoading());
    try {
      List<ProductModel> products = await ProductService().fetchListProduct();

      emit(ListProductLoaded(products));
    } on SocketException {
      emit(const ProductError('No internet connection'));
    } on FirebaseException catch (e) {
      emit(ProductError(e.message!));
    }
  }

  Future<ProductModel> getProduct(String productId) async {
    emit(ProductLoading());
    try {
      ProductModel product = await ProductService().fetchProduct(productId);

      emit(ProductLoaded(product));
      return product;
    } on SocketException {
      emit(const ProductError('No internet connection'));
      return const ProductModel(
        productId: '',
        brandName: '',
        title: '',
        price: 0,
      );
    } on FirebaseException catch (e) {
      emit(ProductError(e.message!));
      return const ProductModel(
        productId: '',
        brandName: '',
        title: '',
        price: 0,
      );
    }
  }
}
