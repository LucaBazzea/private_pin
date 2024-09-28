import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "package:private_pin/components/main_menu.dart";
import "package:private_pin/views/home.dart";
import "package:private_pin/views/map.dart";

void main() {
  runApp(const App());
}

final GoRouter _router = GoRouter(initialLocation: "/", routes: [
  GoRoute(path: "/", name: "home", builder: (context, state) => Home()),
  GoRoute(path: "/map", name: "map", builder: (context, state) => Map())
]);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(title: "Private Pin", routerConfig: _router);
  }
}
