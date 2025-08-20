import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/invoice_model.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(InvoiceModelAdapter());
  await Hive.openBox<InvoiceModel>('invoices');
  runApp(const InvoiceSaverApp());
}

class InvoiceSaverApp extends StatelessWidget {
  const InvoiceSaverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice Saver',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomeScreen(),
    );
  }
}
