import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({super.key});

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {
  /*
  
  */
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(29.3981, 71.6908),
    zoom: 14,
  );

  Set<Polygon> _polygon = HashSet<Polygon>();

  List<LatLng> points = [
    const LatLng(29.3981, 71.6908),
    const LatLng(29.3889, 71.6808),
    const LatLng(29.395722, 71.683333),
    const LatLng(29.3730707, 71.6666226),
    const LatLng(29.4308, 71.6517),
    const LatLng(29.3981, 71.6908),
  ];

  @override
  void initState() {
    super.initState();
    _polygon.add(
      Polygon(
        polygonId: const PolygonId('1'),
        points: points,
        fillColor: Colors.red.withOpacity(0.5),
        geodesic: true,
        strokeWidth: 4,
        strokeColor: Colors.deepOrange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          polygons: _polygon,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
