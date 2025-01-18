import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  String? md5;

  void setMd5({required String md5Value}) {
    md5 = md5Value;
    notifyListeners();
  }
}
