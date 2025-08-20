import 'package:hive/hive.dart';

part 'invoice_model.g.dart';

@HiveType(typeId: 0)
class InvoiceModel extends HiveObject {
  @HiveField(0)
  String productName;

  @HiveField(1)
  String storeName;

  @HiveField(2)
  String purchaseDate;

  @HiveField(3)
  String warrantyPeriod;

  @HiveField(4)
  String expirationDate;

  @HiveField(5)
  String imagePath;

  InvoiceModel({
    required this.productName,
    required this.storeName,
    required this.purchaseDate,
    required this.warrantyPeriod,
    required this.expirationDate,
    required this.imagePath,
  });
}
