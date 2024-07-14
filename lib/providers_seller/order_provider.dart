import 'package:flutter/material.dart';

class OrderProviderSeller with ChangeNotifier {
  String? status;

  filterOrder(status) {
    this.status = status;
    notifyListeners();
  }
}
