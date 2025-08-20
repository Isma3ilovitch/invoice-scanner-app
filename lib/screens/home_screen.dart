import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/invoice_model.dart';
import 'invoice_detail_screen.dart';
import 'add_invoice_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Box<InvoiceModel> invoiceBox = Hive.box<InvoiceModel>('invoices');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Invoices')),
      body: ValueListenableBuilder(
        valueListenable: invoiceBox.listenable(),
        builder: (context, Box<InvoiceModel> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No invoices saved.'));
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final invoice = box.getAt(index)!;
              return ListTile(
                leading: const Icon(Icons.receipt_long),
                title: Text(invoice.productName),
                subtitle: Text('Purchased on ${invoice.purchaseDate}'),
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (_) => InvoiceDetailScreen(invoice: invoice)),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AddInvoiceScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
