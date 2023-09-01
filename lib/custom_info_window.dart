import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomInfoWindowScreen extends StatefulWidget {
  const CustomInfoWindowScreen({Key? key}) : super(key: key);

  @override
  State<CustomInfoWindowScreen> createState() => _CustomInfoWindowScreenState();
}

class _CustomInfoWindowScreenState extends State<CustomInfoWindowScreen> {
  CustomInfoWindowController _infocontroller = CustomInfoWindowController();
  List<Marker> _marker = [];
  List<LatLng> _latlng = <LatLng>[
    LatLng(31.7035, 74.0174),
    LatLng(31.7121, 73.9768),
    LatLng(31.711225325, 73.9910132075),
    LatLng(31.45323, 73.11476),
    LatLng(31.7124, 73.9621)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < _latlng.length; i++) {
      _marker.add(Marker(
        markerId: MarkerId(i.toString()),
        icon: BitmapDescriptor.defaultMarker,
        position: _latlng[i],
        onTap: (){
          _infocontroller.addInfoWindow!(
              Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                  color: Colors.white
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: NetworkImage("https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pexels.com%2Fsearch%2Fcaf%25C3%25A9%2F&psig=AOvVaw3iZ0nML1W6mcfmvuBC2LpH&ust=1693562038648000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCMD6uPrPhoEDFQAAAAAdAAAAABAE")
                        ),
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    Column(
                      children: [
                        const Text("cafe name", style: TextStyle(fontWeight: FontWeight.bold),),
                        Row(
                          children: const [
                            Text("20", style: TextStyle(color: Colors.red),),
                            Icon(Icons.person, color: Colors.red,)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              _latlng[i]
          );
        }
      ));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map with info window"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(31.7035, 74.0174),zoom: 14),
            onMapCreated: (GoogleMapController con){
                _infocontroller.googleMapController=con;
            },
            onTap: (position){
                _infocontroller.hideInfoWindow!();
            },
            onCameraMove: (position){
                _infocontroller.onCameraMove!();
            },
            markers: Set.of(_marker),
          ),
          CustomInfoWindow(controller: _infocontroller,
          height: 200,
          width: 300,
          offset: 35,)
        ],
      ),
    );
  }
}
