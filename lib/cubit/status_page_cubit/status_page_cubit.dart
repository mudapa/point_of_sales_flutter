import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/payment_model.dart';

class StatusPageCubit extends Cubit<List<Payment>> {
  StatusPageCubit() : super([]);

  void fetchPayments() async {
    final paymentsSnapshot =
        await FirebaseFirestore.instance.collection('payments').get();
    final payments = paymentsSnapshot.docs
        .map((doc) => Payment.fromMap(doc.data()))
        .toList();
    emit(payments);
  }
}
