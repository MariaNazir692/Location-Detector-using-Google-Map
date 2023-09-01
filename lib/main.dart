import 'package:flutter/material.dart';
import 'package:google_map_integration/current_user_location.dart';
import 'package:google_map_integration/custom_info_window.dart';
import 'package:google_map_integration/custom_marker_screen.dart';
import 'package:google_map_integration/search_place.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CustomInfoWindowScreen(),
    );
  }
}


