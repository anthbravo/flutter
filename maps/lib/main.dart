import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logging/logging.dart';
import 'package:maps/providers/driver_provider.dart';
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
            value: DriverProvider(),
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

  late GoogleMapController googleMapController;

  void loadDriver(BuildContext context) {
    Provider.of<DriverProvider>(context, listen: false)
        .drive(this.googleMapController);
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = Provider.of<DriverProvider>(context).getMarkers;
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: START_POSITION,
        zoomControlsEnabled: false,
        onMapCreated: onMapCreatedEvent,
        markers: markers,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
        onPressed: () {
          loadDriver(context);
        },
      ),
    );
  }

  void onMapCreatedEvent(controller) {
    googleMapController = controller;
  }
}
