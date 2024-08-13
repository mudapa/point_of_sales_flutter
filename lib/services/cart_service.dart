import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_pos/models/cart_model.dart';

import '../shared/helper.dart';

class CartService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'cart_channel',
      'Cart Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  Future<CartModel> addToCart({
    required String userId,
    required String productId,
    required String size,
    required int quantity,
    required int price,
  }) async {
    try {
      var cartId = cartRef.doc().id;

      CartProductModel product = CartProductModel(
        productId: productId,
        size: size,
        quantity: quantity,
        price: price,
      );

      var checkUserId = await cartRef.where('userId', isEqualTo: userId).get();

      if (checkUserId.docs.isNotEmpty) {
        // if user already have cart then add product to existing cart
        var cart = checkUserId.docs.first;
        var products = cart['products']
            .map<CartProductModel>((e) => CartProductModel.fromJson(e))
            .toList();

        products.add(product);

        await cartRef.doc(cart.id).update({
          'products': products.map((e) => e.toJson()).toList(),
        });

        await _showNotification('Success', 'Product added to cart');

        return CartModel(id: cart.id, userId: userId, products: products);
      } else {
        await cartRef.doc(cartId).set({
          'id': cartId,
          'userId': userId,
          'products': [product.toJson()],
        });

        await _showNotification('Success', 'Product added to cart');

        return CartModel(id: cartId, userId: userId, products: [product]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CartModel> getCart(String userId) async {
    try {
      var checkUserId = await cartRef.where('userId', isEqualTo: userId).get();

      if (checkUserId.docs.isNotEmpty) {
        var cart = checkUserId.docs.first;
        var products = cart['products']
            .map<CartProductModel>((e) => CartProductModel.fromJson(e))
            .toList();

        return CartModel(id: cart.id, userId: userId, products: products);
      }

      return CartModel(id: '', userId: userId, products: []);
    } catch (e) {
      rethrow;
    }
  }

  Future<CartModel> increaseQuantity({
    required String userId,
    required String productId,
  }) async {
    try {
      var checkUserId = await cartRef.where('userId', isEqualTo: userId).get();

      if (checkUserId.docs.isNotEmpty) {
        var cart = checkUserId.docs.first;

        var products = cart['products']
            .map<CartProductModel>((e) => CartProductModel.fromJson(e))
            .toList();

        var index = products.indexWhere(
          (element) => element.productId == productId,
        );

        products[index].quantity++;

        await cartRef.doc(cart.id).update({
          'products': products.map((e) => e.toJson()).toList(),
        });

        return CartModel(id: cart.id, userId: userId, products: products);
      }

      return CartModel(id: '', userId: userId, products: []);
    } catch (e) {
      rethrow;
    }
  }

  Future<CartModel> decreaseQuantity({
    required String userId,
    required String productId,
  }) async {
    try {
      var checkUserId = await cartRef.where('userId', isEqualTo: userId).get();

      if (checkUserId.docs.isNotEmpty) {
        var cart = checkUserId.docs.first;
        var products = cart['products']
            .map<CartProductModel>((e) => CartProductModel.fromJson(e))
            .toList();

        var index = products.indexWhere(
          (element) => element.productId == productId,
        );

        if (products[index].quantity > 1) {
          products[index].quantity--;

          await cartRef.doc(cart.id).update({
            'products': products.map((e) => e.toJson()).toList(),
          });
        }

        return CartModel(id: cart.id, userId: userId, products: products);
      }

      return CartModel(id: '', userId: userId, products: []);
    } catch (e) {
      rethrow;
    }
  }

  Future<CartModel> removeProduct({
    required String userId,
    required String productId,
  }) async {
    try {
      var checkUserId = await cartRef.where('userId', isEqualTo: userId).get();

      if (checkUserId.docs.isNotEmpty) {
        var cart = checkUserId.docs.first;
        var products = cart['products']
            .map<CartProductModel>((e) => CartProductModel.fromJson(e))
            .toList();

        products.removeWhere((element) => element.productId == productId);

        await cartRef.doc(cart.id).update({
          'products': products.map((e) => e.toJson()).toList(),
        });

        return CartModel(id: cart.id, userId: userId, products: products);
      }

      return CartModel(id: '', userId: userId, products: []);
    } catch (e) {
      rethrow;
    }
  }
}
