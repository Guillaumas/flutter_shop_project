import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class InfoPage extends StatelessWidget {
  InfoPage({super.key});

  final _controller = MapController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Info'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Stack(
                  children: [
                    FlutterMap(
                      mapController: _controller,
                      options: const MapOptions(
                        initialCenter:
                            LatLng(47.2061507269755, -1.5394112547796752),
                        zoom: 17.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c'],
                        ),
                        const MarkerLayer(
                          markers: [
                            Marker(
                                width: 80.0,
                                height: 80.0,
                                point:
                                    LatLng(47.2061507269755, -1.5394112547796752),
                                child: Icon(
                                  Icons.school,
                                  size: 40,
                                  color: Colors.green,
                                )),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 20.0,
                      right: 20.0,
                      child: Column(
                        children: [
                          FloatingActionButton(
                            child: const Icon(Icons.zoom_in),
                            onPressed: () {
                              var zoom = _controller.zoom;
                              _controller.move(_controller.center, zoom + 1);
                            },
                          ),
                          const SizedBox(height: 20),
                          FloatingActionButton(
                            child: const Icon(Icons.zoom_out),
                            onPressed: () {
                              var zoom = _controller.zoom;
                              _controller.move(_controller.center, zoom - 1);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'EPSI Nantes is a great place for learning and developing your skills in IT. It offers a variety of courses and programs to suit your needs.',
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
