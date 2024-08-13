import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/report_page_cubit/report_page_cubit.dart';
import '../../models/order_model.dart';
import 'components/category_filter.dart';
import 'components/date_filter.dart';
import 'components/order_list_item.dart';
import 'components/price_filter.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const DateFilter(),
              const PriceFilter(),
              const CategoryFilter(),
              Expanded(
                child: BlocBuilder<ReportPageCubit, List<Orders>>(
                  builder: (context, orders) {
                    if (orders.isEmpty) {
                      return const Center(child: Text('No orders found.'));
                    }

                    return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return OrderListItem(order: order);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
