import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import 'map_screen.dart';

class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({Key? key}) : super(key: key);

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  TextEditingController _controller = TextEditingController();
  String sessionToken = '123456';
  var uuid = Uuid();
  List<dynamic> place_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (sessionToken == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String Api_Key = "AIzaSyDfj5LV3HDhcJW2tVA5Dwqf8J0YK4B9hzI";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$Api_Key&sessiontoken=$sessionToken';
    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      setState(() {
        place_list = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Failed to load");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Location"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: "Search Places....",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Expanded(
              child: ListView.builder(
              itemCount: place_list.length,
              itemBuilder: (context, index) {
               return ListTile(
                 onTap: ()async{
                 //  List<Location> locations = await locationFromAddress(place_list[index]['description']);
                   List<Location> locations =
                   await locationFromAddress(place_list[index]['description']);
                   if (locations.isNotEmpty) {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => MapScreen(
                           latitude: locations[0].latitude,
                           longitude: locations[0].longitude,
                         ),
                       ),
                     );
                   }
                 },
                title: Text(place_list[index]['description']),
              );

          }))
        ],
      ),
    );
  }
}
