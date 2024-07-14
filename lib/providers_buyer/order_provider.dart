import 'package:flutter/material.dart';

class OrderProviderBuyer with ChangeNotifier {
  String? status;

  filterOrder(status) {
    this.status = status;
    notifyListeners();
  }
}
