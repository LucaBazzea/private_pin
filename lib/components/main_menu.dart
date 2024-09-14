import "package:flutter/material.dart";

import "package:private_pin/views/home.dart";

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Text("Private Pin"),
            ),
          ),
          ListTile(title: Text("Home"))
        ],
      ),
    );
  }
}
