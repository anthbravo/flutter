import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:logging/logging.dart';
import 'package:maps/providers/map_provider.dart';
import 'package:provider/provider.dart';

void main() {
  _setupLogging();
  runApp(MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
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

  static const START_POSITION = CameraPosition(
      target: LatLng(-11.997753825747768, -77.10128308860702), zoom: 16);
  Location location = Location();

  late GoogleMapController googleMapController;

  void loadRoute(BuildContext context) {
    Provider.of<MapProvider>(context, listen: false).getMarks();
  }

  @override
  Widget build(BuildContext context) {
    List<LatLng> polylines = Provider.of<MapProvider>(context).getPolylines;
    Set<Marker> markers = Provider.of<MapProvider>(context).getMarkers;
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: START_POSITION,
          zoomControlsEnabled: false,
          // onMapCreated: onMapCreatedEvent,
          markers: markers,
          polylines: {
            if (polylines.length > 0)
              Polyline(
                polylineId: const PolylineId('overview_polyline'),
                color: Colors.red,
                width: 5,
                points: polylines,
              ),
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
        onPressed: () {
          loadRoute(context);
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
