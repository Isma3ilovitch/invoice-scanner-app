import 'dart:io';
import 'package:flutter/material.dart';
import '../models/invoice_model.dart';
import 'edit_invoice_screen.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final InvoiceModel invoice;
  const InvoiceDetailScreen({super.key, required this.invoice});

  void _deleteInvoice(BuildContext context) async {
    await invoice.delete();
    Navigator.pop(context);
  }

  void _editInvoice(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => EditInvoiceScreen(invoice: invoice)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Details'),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () => _editInvoice(context)),
          IconButton(icon: const Icon(Icons.delete), onPressed: () => _deleteInvoice(context)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            invoice.imagePath.isNotEmpty
                ? Image.file(File(invoice.imagePath), height: 250, width: double.infinity, fit: BoxFit.cover)
                : const SizedBox(),
            const SizedBox(height: 20),
            _buildInfo('🛒 Product Name', invoice.productName),
            _buildInfo('🏬 Store Name', invoice.storeName),
            _buildInfo('📅 Purchase Date', invoice.purchaseDate),
            _buildInfo('⏳ Warranty Period', invoice.warrantyPeriod),
            _buildInfo('📆 Expiration Date', invoice.expirationDate),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title: ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
