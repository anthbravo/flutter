import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maps/providers/map_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: MapProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Maps(),
        ));
  }
}

class Maps extends StatelessWidget {
  Maps({Key? key}) : super(key: key);

  static const START_POSITION =
      CameraPosition(target: LatLng(-9.998052, -77.101699), zoom: 16);
  Location location = Location();

  late GoogleMapController googleMapController;

  Marker origin = Marker(
      markerId: const MarkerId('origin'),
      infoWindow: InfoWindow(
          title: 'Origen',
          snippet: 'Latitud: -11.998052, Longitud: -77.101699'),
      position: const LatLng(-11.998052, -77.101699));
  Marker destination = Marker(
      markerId: const MarkerId('destination'),
      infoWindow: const InfoWindow(
          title: 'Destino',
          snippet: 'Latitud: -11.996980, Longitud: -77.101067'),
      position: const LatLng(-11.996980, -77.101067));

  void changeDirection(BuildContext context, List<LatLng> direction) {
    Provider.of<MapProvider>(context, listen: false).changeDirection(direction);
  }

  @override
  Widget build(BuildContext context) {
    var direction = Provider.of<MapProvider>(context).getDirection;
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: START_POSITION,
          zoomControlsEnabled: false,
          onMapCreated: onMapCreatedEvent,
          markers: {
            origin,
            destination
          },
          polylines: {
            if (direction.length > 0)
              Polyline(
                polylineId: const PolylineId('overview_polyline'),
                color: Colors.red,
                width: 5,
                points: direction,
              ),
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
        onPressed: () {
          changeDirection(context, [origin.position, destination.position]);
        },
      ),
    );
  }

  void onMapCreatedEvent(controller) {
    googleMapController = controller;
    location.onLocationChanged.listen((location) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(location.latitude!, location.longitude!),
              zoom: 16),
        ),
      );
    });
  }
}
