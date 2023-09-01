import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserCurrentLocationScreen extends StatefulWidget {
  const UserCurrentLocationScreen({Key? key}) : super(key: key);

  @override
  State<UserCurrentLocationScreen> createState() =>
      _UserCurrentLocationScreenState();
}

class _UserCurrentLocationScreenState extends State<UserCurrentLocationScreen> {
  final List<Marker> _marker = [];
  final List<Marker> _list = [
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(31.716661, 73.985023),
        infoWindow: InfoWindow(title: "My location"))
  ];

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(31.716661, 73.985023), zoom: 14.4746);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Curret lcation of user"),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationEnabled: true,
        compassEnabled: true,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      bottomNavigationBar: InkWell(
        onTap: ()async{
          await getUserCurrentLocation().then((value) async {
            _marker.add(Marker(
                markerId: MarkerId('3'),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: InfoWindow(title: "Current Location")));
            CameraPosition cameraPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude), zoom: 14);
            GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: Container(
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: Center(
              child: Text(
            "Get User Current Location",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });
    return Geolocator.getCurrentPosition();
  }
}
