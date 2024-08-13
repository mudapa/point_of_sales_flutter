import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/order_model.dart';

class ReportPageCubit extends Cubit<List<Orders>> {
  ReportPageCubit() : super([]);

  void fetchOrders({
    DateTime? startDate,
    DateTime? endDate,
    double? minPrice,
    double? maxPrice,
    String? productId,
  }) async {
    Query query = FirebaseFirestore.instance.collection('orders');

    if (startDate != null) {
      query = query.where(
        'transactionDate',
        isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
      );
    }

    if (endDate != null) {
      query = query.where(
        'transactionDate',
        isLessThanOrEqualTo: Timestamp.fromDate(endDate),
      );
    }

    if (minPrice != null) {
      query = query.where('totalPrice', isGreaterThanOrEqualTo: minPrice);
    }

    if (maxPrice != null) {
      query = query.where('totalPrice', isLessThanOrEqualTo: maxPrice);
    }

    if (productId != null) {
      query = query.where('productId', isEqualTo: productId);
    }

    try {
      final ordersSnapshot = await query.get();
      final orders = ordersSnapshot.docs
          .map((doc) => Orders.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      emit(orders);
    } catch (e) {
      emit([]);
    }
  }
}
