import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_location_marker/flutter_map_location_marker.dart";
import "package:latlong2/latlong.dart";

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final MapController _mapController = MapController();
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _updateMap();
  }

  Future<void> _updateMap() async {
    final response = await http.get(Uri.parse('https://your-api.com/data'));
    final jsonData = jsonDecode(response.body);

    // Update the map with new data
    setState(() {
      _markers = jsonData.map((feature) {
        return Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(feature['lat'], feature['lon']),
          child: const Icon(Icons.location_pin),
        );
      }).toList();
    });

    // Schedule the next update
    Future.delayed(const Duration(seconds: 10), _updateMap);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: LatLng(37.7749, -122.4194),
        initialZoom: 12.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: const ["a", "b", "c"],
        ),
        MarkerLayer(markers: _markers),
      ],
    );
  }
}
