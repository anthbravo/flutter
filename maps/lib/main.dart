import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Maps(),
    );
  }
}

class Maps extends StatefulWidget {
  Maps({Key? key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
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

  List<LatLng> direction = [];

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          setState(() {
            direction = [origin.position, destination.position];
          });
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
