import '../models/product_model.dart';
import '../shared/helper.dart';

class ProductService {
  Future<List<ProductModel>> fetchListProduct() async {
    try {
      var snapshot = await productRef.get();
      List<ProductModel> products = snapshot.docs
          .map((e) =>
              ProductModel.fromJson(e.id, e.data() as Map<String, dynamic>))
          .toList();

      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel> fetchProduct(String productId) async {
    try {
      var snapshot = await productRef.doc(productId).get();

      return ProductModel.fromJson(
          productId, snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
