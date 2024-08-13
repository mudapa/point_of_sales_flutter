import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cart_cubit/cart_cubit.dart';
import '../../cubit/cart_cubit/cart_quantity_cubit/cart_quantity_cubit.dart';
import '../../cubit/product_cubit/product_cubit.dart';
import '../../shared/helper.dart';
import '../component_export.dart';

class CartCard extends StatelessWidget {
  final String productId, size;
  final int quantity;
  const CartCard({
    super.key,
    required this.productId,
    required this.size,
    required this.quantity,
  });

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

          return BlocConsumer<CartQuantityCubit, CartQuantityState>(
            listener: (context, state) {
              if (state is CartIncrease ||
                  state is CartDecrease ||
                  state is CartDelete) {
                var cartCubit = context.read<CartCubit>();
                String userId = settings.get('id');
                cartCubit.getCart(userId);
              }
            },
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border(
                    bottom: BorderSide(
                      color: greyColor.withOpacity(0.5),
                    ),
                  ),
                ),
                height: 155,
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.15,
                      child: Stack(
                        children: [
                          NetworkImageWithLoader(product.image!,
                              radius: defaultBorderRadious),
                          if (product.dicountpercent != null)
                            Positioned(
                              right: defaultPadding / 2,
                              top: defaultPadding / 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPadding / 2),
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: errorColor,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(defaultBorderRadious)),
                                ),
                                child: Text(
                                  "${product.dicountpercent}% off",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    const SizedBox(width: defaultPadding),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.brandName.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 10),
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        SizedBox(
                          width: 140,
                          child: Text(
                            product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: defaultPadding / 4),
                        Row(
                          children: [
                            Text(
                              "\$${(product.priceAfetDiscount ?? product.price) * quantity}",
                              style: const TextStyle(
                                color: Color(0xFF31B0D8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: defaultPadding / 4),
                            if (product.priceAfetDiscount != null)
                              Text(
                                " \$${(product.price) * quantity}",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color,
                                  fontSize: 10,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                context.read<CartQuantityCubit>().decreaseCart(
                                      userId: settings.get('id'),
                                      productId: productId,
                                    );
                              },
                              style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(40, 40),
                                  maximumSize: const Size(40, 40),
                                  padding: const EdgeInsets.all(8)),
                              child: const Icon(Icons.remove, size: 20),
                            ),
                            const SizedBox(width: defaultPadding / 2),
                            Text(quantity.toString(),
                                style: Theme.of(context).textTheme.titleSmall!),
                            const SizedBox(width: defaultPadding / 2),
                            OutlinedButton(
                              onPressed: () {
                                context.read<CartQuantityCubit>().increaseCart(
                                      userId: settings.get('id'),
                                      productId: productId,
                                    );
                              },
                              style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(40, 40),
                                  maximumSize: const Size(40, 40),
                                  padding: const EdgeInsets.all(8)),
                              child: const Icon(Icons.add, size: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<CartQuantityCubit>().deleteCart(
                              userId: settings.get('id'),
                              productId: productId,
                            );
                      },
                      icon: const Icon(Icons.delete, color: errorColor),
                    ),
                  ],
                ),
              );
            },
          );
        }

        return const Center(
          child: Text('No product data available'),
        );
      },
    );
  }
}
