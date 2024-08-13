import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/report_page_cubit/report_page_cubit.dart';

class PriceFilter extends StatefulWidget {
  const PriceFilter({super.key});

  @override
  State<PriceFilter> createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  double _minPrice = 0;
  double _maxPrice = 10000;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Slider(
                min: 0,
                max: 1000,
                onChanged: (value) {
                  setState(() {
                    _minPrice = value;
                  });
                  context
                      .read<ReportPageCubit>()
                      .fetchOrders(minPrice: _minPrice);
                },
                label: 'Min Price: \$${_minPrice.toStringAsFixed(0)}',
                value: _minPrice,
              ),
            ),
            Text('\$${_minPrice.toStringAsFixed(0)}'),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Slider(
                min: 0,
                max: 10000,
                onChanged: (value) {
                  setState(() {
                    _maxPrice = value;
                  });
                  context
                      .read<ReportPageCubit>()
                      .fetchOrders(maxPrice: _maxPrice);
                },
                label: 'Max Price: \$${_maxPrice.toStringAsFixed(0)}',
                value: _maxPrice,
              ),
            ),
            Text('\$${_maxPrice.toStringAsFixed(0)}'),
          ],
        ),
      ],
    );
  }
}
