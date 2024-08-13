import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cart_cubit/cart_cubit.dart';
import '../../shared/helper.dart';
import '../view_export.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    var cartCubit = context.read<CartCubit>();
    String userId = settings.get('id');
    cartCubit.getCart(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CartLoaded) {
            final carts = state.carts;

            if (carts.products == [] || carts.products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Cart is empty"),
                    gapH,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        maximumSize: const Size(150, 50),
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, entryPointPageRoute, (route) => false);
                      },
                      child: const Text("Go Shopping"),
                    ),
                  ],
                ),
              );
            } else {
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                      vertical: defaultPadding,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return CartCard(
                            productId: carts.products[index].productId,
                            size: carts.products[index].size,
                            quantity: carts.products[index].quantity,
                          );
                        },
                        childCount: carts.products.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!
                                            .withOpacity(0.3),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        defaultBorderRadious,
                                      ),
                                    ),
                                    hintText: "Voucher code",
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: defaultPadding * 0.75),
                                      child: SvgPicture.asset(
                                        "assets/icons/Gift.svg",
                                        height: 24,
                                        width: 24,
                                        colorFilter: ColorFilter.mode(
                                          Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color!
                                              .withOpacity(0.3),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: defaultPadding / 2),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(100, 50),
                                  maximumSize: const Size(100, 50),
                                ),
                                onPressed: () {},
                                child: const Text("Apply"),
                              ),
                            ],
                          ),
                          gapH,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color),
                              ),
                              Text(
                                "\$${carts.products.fold(0, (prev, e) => prev + (e.price * e.quantity))}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color),
                              ),
                            ],
                          ),
                          const SizedBox(height: defaultPadding),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, paymentPageRoute);
                            },
                            child: const Text("Checkout"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          }

          if (state is CartError) {
            return Center(
              child: Text(state.message),
            );
          }

          return const Center(
            child: Text("Kosong"),
          );
        },
      ),
    );
  }
}
