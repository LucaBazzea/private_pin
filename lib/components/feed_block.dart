import "package:flutter/material.dart";

class Block extends StatelessWidget {
  final String username;
  final double lat;
  final double lon;
  final String lastOnline;

  const Block(
      {Key? key,
      required this.username,
      required this.lat,
      required this.lon,
      required this.lastOnline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
        child: Container(
            height: 200,
            color: Colors.blueGrey,
            child: Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Column(children: [
                    Text(username, style: const TextStyle(fontSize: 32)),
                    Text("Last Online: $lastOnline"),
                  ]),
                  Text("$lat, $lon")
                ]))));
  }
}
