import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ConfigurationProvider extends ChangeNotifier {
  Uuid uuid = Uuid();
  int captureIntervalSecond = 0;
  int captureCount = 0;
  String? currentProcessId;
  List<String> currentImages = [];

  void setCaptureIntervalSecond({required int second}) {
    captureIntervalSecond = second;
    notifyListeners();
  }

  void setCaptureCount({required int value}) {
    captureCount = value;
    notifyListeners();
  }

  void setCurrentProcess() {
    currentProcessId = uuid.v4();
    notifyListeners();
  }

  void appendImage({required String imagePath}) {
    currentImages.add(imagePath);
    notifyListeners();
  }

  void resetImages() {
    currentImages = [];
    notifyListeners();
  }

  void reset() {
    captureIntervalSecond = 0;
    captureCount = 0;
    currentProcessId = null;
    currentImages = [];
    notifyListeners();
  }
}
