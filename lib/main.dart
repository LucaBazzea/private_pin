import "package:flutter/material.dart";

import "package:private_pin/components/main_menu.dart";
import "package:private_pin/views/home.dart";

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text("Private Pin")),
            drawer: const MainMenu(),
            body: const Home()));
  }
}
