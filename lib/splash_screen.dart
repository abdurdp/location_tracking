import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'map_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _fetchAndSaveLocation();
  }

  Future<void> _fetchAndSaveLocation() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, navigate to the next screen
      final locationData = await _getLocation();
      if (locationData != null) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setDouble('latitude', locationData.latitude!);
        prefs.setDouble('longitude', locationData.longitude!);
      }

      // Navigate to the map screen after saving location data
      Future.delayed(Duration.zero, () {
        Get.off(MapScreen());
      });
    } else if (status.isDenied) {
      // Permission denied, show a message or request again
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, open app settings
      openAppSettings();
    }

  }

  Future<LocationData?> _getLocation() async {
    final location = Location();
    try {
      return await location.getLocation();
    } catch (e) {
      print('Error fetching location: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

