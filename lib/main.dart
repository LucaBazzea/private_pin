import "dart:async";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "package:private_pin/services.dart";
import "package:private_pin/components/main_menu.dart";
import "package:private_pin/views/home.dart";
import "package:private_pin/views/map.dart";

void main() {
  runApp(const App());
}

final GoRouter _router = GoRouter(initialLocation: "/", routes: [
  GoRoute(path: "/", name: "home", builder: (context, state) => Home()),
  GoRoute(
      path: "/map/:userID",
      name: "map",
      builder: (context, state) {
        var userID = state.pathParameters["userID"];
        if (userID == null) {
          throw Exception("User ID not provided");
        }
        return Map(userID: userID);
      })
]);

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Timer? _timer;
  bool uploadLocation = true;

  @override
  void initState() {
    super.initState();
    if (uploadLocation) {
      _startLocationUpdates();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startLocationUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getCurrentLocation().then((position) {
        print("User Current Location, main");
        print(position);
      }).catchError((error) {
        print(error);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(title: "Private Pin", routerConfig: _router);
  }
}
