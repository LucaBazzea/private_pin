import "dart:convert";
import "dart:async";
import "package:http/http.dart" as http;
import "package:geolocator/geolocator.dart";
import "package:shared_preferences/shared_preferences.dart";

Future<void> setSessionCookie(String sessionCookie) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("sessionCookie", sessionCookie);
}

Future<String?> getSessionCookie() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("sessionCookie");
}

Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error("Location services are disabled");
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Location permissions are denied");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        "Location permissions are permanently denied, we cannot request permissions");
  }

  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

Future<void> sendLocationToEndpoint(Position position) async {
  String url = 'https://your-endpoint.com/location';
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  Map<String, dynamic> body = {
    'latitude': position.latitude,
    'longitude': position.longitude,
  };

  try {
    http.Response response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200) {
      print('Location data sent successfully');
    } else {
      print('Failed to send location data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending location data: $e');
  }
}

Future<void> mainFunction() async {
  Position position = await getCurrentLocation();
  if (position != null) {
    print("User Current Location: ${position.latitude}, ${position.longitude}");
    await sendLocationToEndpoint(position);
  }
}
