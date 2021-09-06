import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider extends ChangeNotifier {
  List<LatLng> direction = [];

  List<LatLng> get getDirection {
    return this.direction;
  }

  void changeDirection(List<LatLng> direction) {
    this.direction = direction;
    notifyListeners();
  }
}
