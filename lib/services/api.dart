import "dart:convert";
import "package:http/http.dart" as http;

var url = "127.0.0.1:8000/";

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

class Connection {
  final int id;
  final String username;
  final String email;
  final double lat;
  final double lon;
  final DateTime lastOnline;

  Connection(
      {required this.id,
      required this.username,
      required this.email,
      required this.lat,
      required this.lon,
      required this.lastOnline});
}

List<Connection> connections = [];

Future getConnections(String userID) async {
  var response =
      await http.get(Uri.http(url, "app/get-connections?user_id=$userID"));
  var jsonData = jsonDecode(response.body);

  for (var connection in jsonData) {
    final connections = Connection(
      id: connection["id"],
      username: connection["username"],
      email: connection["email"],
      lat: connection["lat"],
      lon: connection["lon"],
      lastOnline: DateTime.parse(connection["last_online"]),
    );
  }
  print(connections);
}

void main() async {
  final userId = "1";
  final connections = await getConnections(userId);
  print(connections);
}
