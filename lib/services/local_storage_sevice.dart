import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> saveData(String username) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString("username", username);
  }

  Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("username") ?? "";
  }

  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove("username");
  }
}
