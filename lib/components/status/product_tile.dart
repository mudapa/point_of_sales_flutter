import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/product_cubit/product_cubit.dart';
import '../component_export.dart';

class ProductTile extends StatelessWidget {
  final String productId;
  const ProductTile({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<ProductCubit>().getProduct(productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.hasData) {
          final product = snapshot.data;

          if (product == null) {
            return const Center(
              child: Text('Product not found'),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.title),
              Text(
                  'Price Per Item: \$${product.priceAfetDiscount ?? product.price}'),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
