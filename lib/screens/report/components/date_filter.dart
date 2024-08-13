import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/report_page_cubit/report_page_cubit.dart';

class DateFilter extends StatefulWidget {
  const DateFilter({super.key});

  @override
  State<DateFilter> createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> {
  DateTime? _startDate;
  DateTime? _endDate;

  void _fetchFilteredOrders() {
    var orderCubit = context.read<ReportPageCubit>();

    if (_startDate != null && _endDate != null) {
      if (_startDate!.isBefore(_endDate!) ||
          _startDate!.isAtSameMomentAs(_endDate!)) {
        orderCubit.fetchOrders(startDate: _startDate, endDate: _endDate);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Start Date should be before End Date')),
        );
      }
    } else if (_startDate != null) {
      orderCubit.fetchOrders(startDate: _startDate);
    } else if (_endDate != null) {
      orderCubit.fetchOrders(endDate: _endDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_startDate != null)
          Text('Start Date: ${_startDate!.toLocal().toString().split(' ')[0]}'),
        if (_endDate != null)
          Text('End Date: ${_endDate!.toLocal().toString().split(' ')[0]}'),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _startDate = selectedDate;
                    });
                    _fetchFilteredOrders(); // Fetch orders setelah memilih start date
                  }
                },
                child: const Text('Select Start Date'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _endDate = selectedDate;
                    });
                    _fetchFilteredOrders(); // Fetch orders setelah memilih end date
                  }
                },
                child: const Text('Select End Date'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
