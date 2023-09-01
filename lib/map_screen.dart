import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  MapScreen({required this.latitude, required this.longitude});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Map"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 14,
        ),
        mapType: MapType.normal,
        myLocationEnabled: true,
        compassEnabled: true,
        markers: {
          Marker(
            markerId: MarkerId("user_selected_location"),
            position: LatLng(widget.latitude, widget.longitude),
            infoWindow: InfoWindow(title: "User Selected Location"),
          ),
        },
      ),
    );
  }
}
