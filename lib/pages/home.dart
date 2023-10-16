import "package:flutter/material.dart";

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("PrivatePin"), backgroundColor: Colors.lightBlue),
        drawer: Drawer(
          child: ListView(
            children: [Text("Uno"), Text("Due"), Text("Tre")],
          ),
        ));
  }
}
