import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "package:private_pin/components/feed_block.dart";
import "package:private_pin/selectors.dart";
import "package:private_pin/services.dart";


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? sessionCookie = getSessionCookie();

    if (sessionCookie == null) {
      context.goNamed("email_input");
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("PrivatePin"),
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
          backgroundColor: Colors.blueGrey,
          elevation: 0,
        ),
        body: FutureBuilder(
            future: getConnections("1"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: connections.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => context.goNamed("map", pathParameters: {
                                "userID": connections[index].id.toString()
                              }),
                          child: Block(
                            lat: connections[index].lat,
                            lon: connections[index].lon,
                            username: connections[index].username,
                            lastOnline:
                                connections[index].lastOnline.toString(),
                          ));
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
