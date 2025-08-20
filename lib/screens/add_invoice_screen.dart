import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import '../models/invoice_model.dart';
import '../utils/parser.dart';

class AddInvoiceScreen extends StatefulWidget {
  const AddInvoiceScreen({super.key});

  @override
  State<AddInvoiceScreen> createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends State<AddInvoiceScreen> {
  File? _imageFile;
  final picker = ImagePicker();
  String productName = '', storeName = '', purchaseDate = '', warrantyPeriod = '', expirationDate = '';
  bool isProcessing = false;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        isProcessing = true;
      });
      await _processImage(_imageFile!);
    }
  }

  Future<void> _processImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognizedText = await textRecognizer.processImage(inputImage);
    final extractedData = parseInvoiceText(recognizedText.text);

    setState(() {
      productName = extractedData['productName'] ?? '';
      storeName = extractedData['storeName'] ?? '';
      purchaseDate = extractedData['purchaseDate'] ?? '';
      warrantyPeriod = extractedData['warrantyPeriod'] ?? '';
      expirationDate = extractedData['expirationDate'] ?? '';
      isProcessing = false;
    });

    await textRecognizer.close();
  }

  Future<void> _saveInvoice() async {
    if (_imageFile == null) return;
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final savedImage = await _imageFile!.copy('${appDir.path}/$fileName.jpg');

    final invoice = InvoiceModel(
      productName: productName,
      storeName: storeName,
      purchaseDate: purchaseDate,
      warrantyPeriod: warrantyPeriod,
      expirationDate: expirationDate,
      imagePath: savedImage.path,
    );

    final box = Hive.box<InvoiceModel>('invoices');
    await box.add(invoice);
    Navigator.pop(context);
  }

  Widget _buildField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Invoice')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _imageFile == null ? const Text('No image selected.') : Image.file(_imageFile!),
              const SizedBox(height: 12),
              if (isProcessing)
                const CircularProgressIndicator()
              else if (_imageFile != null)
                Column(
                  children: [
                    _buildField('Product Name', productName),
                    _buildField('Store Name', storeName),
                    _buildField('Purchase Date', purchaseDate),
                    _buildField('Warranty Period', warrantyPeriod),
                    _buildField('Expiration Date', expirationDate),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _saveInvoice,
                      child: const Text('Save Invoice'),
                    )
                  ],
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.photo),
                    label: const Text('Gallery'),
                    onPressed: () => _getImage(ImageSource.gallery),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                    onPressed: () => _getImage(ImageSource.camera),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
