import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Marker> _marker=[];
  List<Marker> _list=[
    Marker(
        markerId: MarkerId('1'),
      position:  LatLng(31.716661, 73.985023),
      infoWindow: InfoWindow(
        title: "My location"
      )
    )
  ];


  Completer<GoogleMapController> _controller=Completer();

  static final CameraPosition _kGooglePlex=const CameraPosition(
      target: LatLng(31.716661, 73.985023),
    zoom: 14.4746
  );

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationEnabled: true,
        compassEnabled: true,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },

      ),
    );
  }
}
