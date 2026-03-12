import 'package:flutter/material.dart';

class VersionProvider extends ChangeNotifier {
  VersionProvider({required this.total});

  final int total;
  int _current = 1;

  int get current => _current;

  void setVersion(int v) {
    _current = v;
    notifyListeners();
  }
}
