import "dart:convert";
import "package:http/http.dart" as http;

Future<User> getUser(userID) async {
  print("API: $userID");
  final response = await http
      .get(Uri.parse("http://127.0.0.1:8000/app/get-user?id=$userID"));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception("Failed to load user");
  }
}

class User {
  final int id;
  final String username;
  final String lastOnline;
  final double lat;
  final double lon;

  User(
      {required this.id,
      required this.username,
      required this.lastOnline,
      required this.lat,
      required this.lon});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        username: json["username"],
        lastOnline: json["last_online"],
        lat: json["lat"],
        lon: json["lon"]);
  }
}
