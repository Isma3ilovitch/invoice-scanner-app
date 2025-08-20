import 'package:flutter/material.dart';
import '../models/invoice_model.dart';

class EditInvoiceScreen extends StatefulWidget {
  final InvoiceModel invoice;
  const EditInvoiceScreen({super.key, required this.invoice});

  @override
  State<EditInvoiceScreen> createState() => _EditInvoiceScreenState();
}

class _EditInvoiceScreenState extends State<EditInvoiceScreen> {
  late TextEditingController productNameController;
  late TextEditingController storeNameController;
  late TextEditingController purchaseDateController;
  late TextEditingController warrantyPeriodController;
  late TextEditingController expirationDateController;

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController(text: widget.invoice.productName);
    storeNameController = TextEditingController(text: widget.invoice.storeName);
    purchaseDateController = TextEditingController(text: widget.invoice.purchaseDate);
    warrantyPeriodController = TextEditingController(text: widget.invoice.warrantyPeriod);
    expirationDateController = TextEditingController(text: widget.invoice.expirationDate);
  }

  void _saveChanges() async {
    widget.invoice.productName = productNameController.text;
    widget.invoice.storeName = storeNameController.text;
    widget.invoice.purchaseDate = purchaseDateController.text;
    widget.invoice.warrantyPeriod = warrantyPeriodController.text;
    widget.invoice.expirationDate = expirationDateController.text;

    await widget.invoice.save();
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    productNameController.dispose();
    storeNameController.dispose();
    purchaseDateController.dispose();
    warrantyPeriodController.dispose();
    expirationDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Invoice')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildField('Product Name', productNameController),
            _buildField('Store Name', storeNameController),
            _buildField('Purchase Date', purchaseDateController),
            _buildField('Warranty Period', warrantyPeriodController),
            _buildField('Expiration Date', expirationDateController),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _saveChanges, child: const Text('Save Changes')),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      ),
    );
  }
}
