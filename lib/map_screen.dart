import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_controller.dart';class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;

@override
  void initState() {
    Get.put(MapController());
    Get.find<MapController>().updateUserLocation();
    super.initState();
  }
  @override
  void dispose() {
    // Dispose of the GoogleMapController when the widget is disposed
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Location App'),
      ),
      body: Center(
        child: GetBuilder<MapController>(
          init: MapController(),
          builder: (controller) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(24.374, 88.60114),
                zoom: 15.0,
              ),
              markers: controller.locationMarkers,
              onMapCreated: (GoogleMapController gcontroller) {
                // Assign the controller to the state variable
                setState(() {
                  mapController = gcontroller;
                });
                // controller.updateUserLocation();
                mapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    new CameraPosition(
                      target: LatLng(
                          controller.initialLocation!.latitude ?? 0.0, controller.initialLocation!.longitude ?? 0.0),
                      zoom: 15,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapController!.animateCamera(
            CameraUpdate.newCameraPosition(
              new CameraPosition(
                target: LatLng(
                    Get.find<MapController>().initialLocation!.latitude ?? 0.0, Get.find<MapController>().initialLocation!.longitude ?? 0.0),
                zoom: 15,
              ),
            ),
          );
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}



