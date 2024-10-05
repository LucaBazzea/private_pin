import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_location_marker/flutter_map_location_marker.dart";
import "package:latlong2/latlong.dart";

class Map extends StatefulWidget {
  final String userID;

  const Map({super.key, required this.userID});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final MapController _mapController = MapController();
  List<Marker> _markers = [];
  var user;

  @override
  void initState() {
    super.initState();
    _updateMap();
  }

  Future<void> _updateMap() async {
    // final response = await http.get(Uri.parse('https://your-api.com/data'));
    // final jsonData = jsonDecode(response.body);
    user = {
      "id": "1",
      "username": "GordonFreeman",
      "last_online": "14:42",
      "lat": 42.756,
      "lon": 19.373
    };

    setState(() {
      _markers = [
        Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(user["lat"], user["lon"]),
          child: const Icon(Icons.location_pin),
        )
      ];
    });

    // Schedule the next update
    //   Future.delayed(const Duration(seconds: 10), _updateMap);
  }

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
        body: FlutterMap(
          mapController: _mapController,
          options: const MapOptions(
            initialCenter: LatLng(41.90586517413028, 12.482428543480937),
            initialZoom: 4,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const ["a", "b", "c"],
            ),
            MarkerLayer(markers: _markers),
          ],
        ));
  }
}
