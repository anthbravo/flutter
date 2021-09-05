import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/models/direction.dart';

class DirectionService {
  static const String API =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio dio;

  DirectionService({Dio? dio}) : this.dio = dio ?? Dio();

  Future<Direction?> getDirections({
    LatLng? origin,
    LatLng? destination,
  }) async {
    final response = await dio.get(
      API,
      queryParameters: {
        'origin': '${origin!.latitude},${origin.longitude}',
        'destination': '${destination!.latitude},${destination.longitude}',
        'key': 'AIzaSyAjKPU45WcNQONDLImOXmLLWFgempdGfIs',
      },
    );

    if (response.statusCode == 200) {
      return Direction.fromMap(response.data);
    } else {
      return null;
    }
  }
}
