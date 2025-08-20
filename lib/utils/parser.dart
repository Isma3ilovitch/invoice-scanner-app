Map<String, String> parseInvoiceText(String ocrText) {
  final data = <String, String>{};
  final lines = ocrText.split('\n');

  for (var line in lines) {
    final lower = line.toLowerCase();
    if (lower.contains('store') || lower.contains('shop')) {
      data['storeName'] = line;
    }
    if (lower.contains('warranty')) {
      data['warrantyPeriod'] = line;
    }
    if (RegExp(r'\d{2}[\/\-.]\d{2}[\/\-.]\d{4}').hasMatch(line)) {
      data['purchaseDate'] = line;
    }
    if (lower.contains('tv') || lower.contains('fridge') || lower.contains('laptop') || lower.contains('machine')) {
      data['productName'] = line;
    }
  }

  data['expirationDate'] = 'Auto-calculate later';
  return data;
}
