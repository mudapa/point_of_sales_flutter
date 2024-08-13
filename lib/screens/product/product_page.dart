import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cart_cubit/cart_cubit.dart';
import '../../cubit/count_cubit/count_cubit.dart';
import '../../shared/helper.dart';
import '../view_export.dart';

class ProductPage extends StatefulWidget {
  final ProductModel product;
  const ProductPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String selectedSize = '';

  @override
  Widget build(BuildContext context) {
    int count = 0;
    Widget header() {
      return Stack(
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: Stack(
              children: [
                NetworkImageWithLoader(widget.product.image!, radius: 0),
                if (widget.product.dicountpercent != null)
                  Positioned(
                    right: defaultPadding / 2,
                    top: defaultPadding / 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      height: 40,
                      decoration: const BoxDecoration(
                        color: errorColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(defaultBorderRadious)),
                      ),
                      child: Center(
                        child: Text(
                          "${widget.product.dicountpercent} off",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      );
    }

    Widget productInfo() {
      return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.brandName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: defaultPadding / 2),
            Text(
              widget.product.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: defaultPadding),
            Text(
              "Size",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: defaultPadding / 2),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedSize = 'S';
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedSize == 'S'
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(defaultBorderRadious),
                    ),
                    child: Text(
                      'S',
                      style: TextStyle(
                        color: selectedSize == 'S'
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: defaultPadding / 2),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedSize = 'M';
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedSize == 'M'
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(defaultBorderRadious),
                    ),
                    child: Text(
                      'M',
                      style: TextStyle(
                        color: selectedSize == 'M'
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: defaultPadding / 2),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedSize = 'L';
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedSize == 'L'
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(defaultBorderRadious),
                    ),
                    child: Text(
                      'L',
                      style: TextStyle(
                        color: selectedSize == 'L'
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            Row(
              children: [
                Text(
                  "Stock : ${widget.product.stock}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  header(),
                  productInfo(),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "\$${widget.product.priceAfetDiscount ?? widget.product.price}",
                              style: const TextStyle(
                                color: Color(0xFF31B0D8),
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(width: defaultPadding / 4),
                            if (widget.product.priceAfetDiscount != null)
                              Text(
                                "\$${widget.product.price}",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                context.read<CountCubit>().decrement();
                              },
                              style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(40, 40),
                                  maximumSize: const Size(40, 40),
                                  padding: const EdgeInsets.all(8)),
                              child: const Icon(Icons.remove, size: 20),
                            ),
                            const SizedBox(width: defaultPadding / 2),
                            BlocBuilder<CountCubit, int>(
                              builder: (context, counter) {
                                count = counter;
                                return Text("$count",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!);
                              },
                            ),
                            const SizedBox(width: defaultPadding / 2),
                            OutlinedButton(
                              onPressed: () {
                                context.read<CountCubit>().increment();
                              },
                              style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(40, 40),
                                  maximumSize: const Size(40, 40),
                                  padding: const EdgeInsets.all(8)),
                              child: const Icon(Icons.add, size: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                    gapH,
                    BlocConsumer<CartCubit, CartState>(
                      listener: (context, state) {
                        if (state is CartSuccess) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Product added to cart",
                                          style: bodyText),
                                      gapH,
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: successColor,
                                          minimumSize: const Size(80, 50),
                                          maximumSize: const Size(80, 50),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Close"),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }

                        if (state is CartError) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(state.message,
                                          style: bodyText.copyWith(
                                              color: errorColor)),
                                      gapH,
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: errorColor,
                                          minimumSize: const Size(80, 50),
                                          maximumSize: const Size(80, 50),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Close"),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is CartLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ElevatedButton(
                          onPressed: () async {
                            if (count == 0) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.all(defaultPadding),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Please select quantity",
                                              style: bodyText.copyWith(
                                                  color: errorColor)),
                                          gapH,
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: errorColor,
                                              minimumSize: const Size(80, 50),
                                              maximumSize: const Size(80, 50),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Close"),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            if (selectedSize == '') {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.all(defaultPadding),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Please select a size",
                                              style: bodyText.copyWith(
                                                  color: errorColor)),
                                          gapH,
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: errorColor,
                                              minimumSize: const Size(80, 50),
                                              maximumSize: const Size(80, 50),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Close"),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              var cartCubit = context.read<CartCubit>();
                              String userId = await settings.get('id');
                              cartCubit.addCart(
                                userId: userId,
                                productId: widget.product.productId,
                                size: selectedSize,
                                quantity: count,
                                price: widget.product.priceAfetDiscount ??
                                    widget.product.price,
                              );
                            }
                          },
                          child: const Text('Add to Cart'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
