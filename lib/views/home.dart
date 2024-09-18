import "package:flutter/material.dart";

import "package:private_pin/components/feed_block.dart";

class Home extends StatelessWidget {
  final List _items = [
    {
      "username": "GordonFreeman",
      "last_online": "14:42",
      "lat": 1.234,
      "lon": 1.234
    },
    {"username": "Alyx", "last_online": "14:42", "lat": 1.234, "lon": 1.234},
    {"username": "CptEli", "last_online": "14:42", "lat": 1.234, "lon": 1.234},
    {"username": "REDACTED", "last_online": "14:42", "lat": 1.234, "lon": 1.234}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return Block(
                  username: _items[index]["username"],
                  lastOnline: _items[index]["last_online"],
                  lat: _items[index]["lat"],
                  lon: _items[index]["lon"]);
            }));
  }
}
