import 'dart:async';
import 'dart:typed_data';
import 'dart:ui'as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({Key? key}) : super(key: key);

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  List<Marker> _marker = [];
  List<Marker> _list = [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(31.716661, 73.985023),
        infoWindow: InfoWindow(title: "My location"))
  ];

  List<String> images = [
    'assests/images/cafe.png',
    'assests/images/hospital.png',
    'assests/images/hotel.png',
    'assests/images/mall.png',
    'assests/images/office.png'
  ];
  List<LatLng> _latlng = <LatLng>[
    LatLng(31.7035, 74.0174),
    LatLng(31.7121, 73.9768),
    LatLng(31.711225325, 73.9910132075),
    LatLng(31.45323, 73.11476),
    LatLng(31.7124, 73.9621)
  ];

  Uint8List? markerImage;
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(31.716661, 73.985023), zoom: 14.4746);

  Future<Uint8List> getBytesFromAssets(String path, int width)async{
    ByteData data=await rootBundle.load(path);
    ui.Codec codec=await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo frameInfo=await codec.getNextFrame();
    return(await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();


  }

  LoadData()async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List marker_icon=await getBytesFromAssets(images[i], 50);
      _marker.add(Marker(markerId: MarkerId(i.toString()),
          position: _latlng[i],
        infoWindow: InfoWindow(
          title: "This is title"+ i.toString()
        ),
        icon: BitmapDescriptor.fromBytes(marker_icon)
      ));
      setState(() {

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadData();
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
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
