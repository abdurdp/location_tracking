// Save data to shared preferences
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveData() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('key', 'value'); // Replace 'key' and 'value' with your data
}

// Retrieve data from shared preferences
Future<String?> loadData() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('key'); // Replace 'key' with your data key
}

// Remove data from shared preferences
Future<void> removeData() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('key'); // Replace 'key' with your data key
}
