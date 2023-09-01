
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';



class LongLtnToAddress extends StatefulWidget {
  const LongLtnToAddress({Key? key}) : super(key: key);

  @override
  State<LongLtnToAddress> createState() => _LongLtnToAddressState();
}

class _LongLtnToAddressState extends State<LongLtnToAddress> {
  String _longlati = '';
  String add='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(_longlati),
          Text(add),
          SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(double.infinity, 50),
            ),
            onPressed: () async {
              List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
              List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
              setState(() {
                _longlati=locations.last.longitude.toString()+ " " +locations.last.latitude.toString();
                add=placemarks.reversed.last.country.toString()+" "+placemarks.reversed.last.locality.toString();

              });



            },
            child: Text("Convert"),
          ),
        ],
      ),
    );
  }
}
