import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "package:private_pin/components/feed_block.dart";
import "package:private_pin/selectors.dart";
import "package:private_pin/services.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getSessionCookie().then((sessionCookie) {
      if (sessionCookie == null) {
        context.goNamed("email_input");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSessionCookie(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String? sessionCookie = snapshot.data;

          if (sessionCookie == null) {
            context.goNamed("email_input");
            return const SizedBox();
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text("PrivatePin"),
              centerTitle: true,
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
              ],
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
                          lastOnline: connections[index].lastOnline.toString(),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        } else {
          context.goNamed("email_input");
          return const SizedBox();
        }
      },
    );
  }
}
