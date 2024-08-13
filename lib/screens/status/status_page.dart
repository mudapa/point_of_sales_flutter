import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../components/status/product_tile.dart';
import '../../cubit/status_page_cubit/status_page_cubit.dart';
import '../../models/payment_model.dart';
import '../../route/route_constans.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<StatusPageCubit>().fetchPayments();
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Status')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<StatusPageCubit, List<Payment>>(
                  builder: (context, payments) {
                    if (payments.isEmpty) {
                      return const Center(child: Text('No payments found.'));
                    }

                    return ListView.builder(
                      itemCount: payments.length,
                      itemBuilder: (context, index) {
                        final payment = payments[index];
                        // Menampilkan detail product
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Payment ID: ${payment.paymentId}',
                                  style: const TextStyle(fontSize: 18)),
                              Text('Status: ${payment.status}'),
                              Text('Date: ${payment.order.transactionDate}'),
                              const SizedBox(height: 16),
                              const Text('Order Details:',
                                  style: TextStyle(fontSize: 16)),
                              Text('Order ID: ${payment.order.orderId}'),
                              ProductTile(
                                productId: payment.order.productId,
                              ),
                              Text('Quantity: ${payment.order.quantity}'),
                              Text(
                                  'Total Price: \$${payment.order.totalPrice}'),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => _generatePdf(payment),
                                child: const Text('Generate PDF'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, entryPointPageRoute, (route) => false);
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _generatePdf(Payment payment) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll57,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Payment ID: ${payment.paymentId}',
                  style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Status: ${payment.status}'),
              pw.Text('Date: ${payment.order.transactionDate}'),
              pw.SizedBox(height: 16),
              pw.Text('Order Details:',
                  style: const pw.TextStyle(fontSize: 16)),
              pw.Text('Order ID: ${payment.order.orderId}'),
              pw.Text('Quantity: ${payment.order.quantity}'),
              pw.Text('Total Price: \$${payment.order.totalPrice}'),
            ],
          );
        },
      ),
    );

    // Menampilkan preview PDF atau menyimpannya
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
