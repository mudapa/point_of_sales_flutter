import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/report_page_cubit/report_page_cubit.dart';

class CategoryFilter extends StatefulWidget {
  const CategoryFilter({super.key});

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedCategory,
      hint: const Text('Select Product Category'),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
        context.read<ReportPageCubit>().fetchOrders(productId: value);
      },
      items: const [
        DropdownMenuItem(
          value: 'IyMCltezhQs9Dc3RJy5i',
          child: Text('Ruffle-Sleeve Ponte-Knit Sheath'),
        ),
        DropdownMenuItem(
          value: 'MeGt8HkraGAhm1q9tpHl',
          child: Text('FS - Nike Air Max 270 Really React'),
        ),
        DropdownMenuItem(
          value: 'MiEbfxRrqZ1SY9daF0yb',
          child: Text('Green Poplin Ruched Front'),
        ),
        DropdownMenuItem(
          value: 'eENLSJ3edLYcKJLOOPbL',
          child: Text('White satin corset top'),
        ),
        DropdownMenuItem(
          value: 'l0WYCV4npuOQvOvwJySU',
          child: Text('Mountain Warehouse for Women'),
        ),
        DropdownMenuItem(
          value: 'vPZvoyJjWT0Fd6A8nLVy',
          child: Text('Mountain Beta Warehouse'),
        ),
      ],
    );
  }
}
