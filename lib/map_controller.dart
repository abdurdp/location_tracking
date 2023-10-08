
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MapController extends GetxController {
  GoogleMapController? mapController;
  Set<Marker> locationMarkers = {};
  LatLng initialLocation = LatLng(24.374, 88.60114); // Default location

  @override
  void onInit() {
    _loadSavedLocation();
    _initLocationListener(); // Initialize location change listener
    super.onInit();
  }

  Future<void> _loadSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final latitude = prefs.getDouble('latitude') ?? 0.0;
    final longitude = prefs.getDouble('longitude') ?? 0.0;
    initialLocation = LatLng(latitude, longitude);
    locationMarkers.add(Marker(
      markerId: MarkerId('user_location'),
      position: initialLocation,
    ));
    update();
  }

  // Initialize location change listener
  void _initLocationListener() {
    final location = Location();

    location.onLocationChanged.listen((LocationData locationData) {
      // Update the locationMarkers and initialLocation whenever location changes
      locationMarkers.clear();
      locationMarkers.add(Marker(
        markerId: MarkerId('user_location'),
        position: LatLng(locationData.latitude!, locationData.longitude!),
      ));
      initialLocation = LatLng(locationData.latitude!, locationData.longitude!);
      update();
    });
  }

  void updateUserLocation() async {
    final locationData = await _getLocation();
    if (locationData != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setDouble('latitude', locationData.latitude!);
      prefs.setDouble('longitude', locationData.longitude!);
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
  void onClose() {
    // mapController!.dispose();
    super.onClose();
  }
}

