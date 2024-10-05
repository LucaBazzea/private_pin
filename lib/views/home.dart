import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "package:private_pin/components/feed_block.dart";

class Home extends StatelessWidget {
  final List _items = [
    {
      "id": "1",
      "username": "GordonFreeman",
      "last_online": "14:42",
      "lat": 1.234,
      "lon": 1.234
    },
    {
      "id": "2",
      "username": "Alyx",
      "last_online": "14:42",
      "lat": 1.234,
      "lon": 1.234
    },
    {
      "id": "3",
      "username": "CptEli",
      "last_online": "14:42",
      "lat": 1.234,
      "lon": 1.234
    },
    {
      "id": "4",
      "username": "REDACTED",
      "last_online": "14:42",
      "lat": 1.234,
      "lon": 1.234
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("PrivatePin"),
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
          backgroundColor: Colors.blueGrey,
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () => context.goNamed("map",
                      pathParameters: {"userID": _items[index]["id"]}),
                  child: Block(
                      username: _items[index]["username"],
                      lastOnline: _items[index]["last_online"],
                      lat: _items[index]["lat"],
                      lon: _items[index]["lon"]));
            }));
  }
}
