import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*
     Completer class is used to manually complete or cancel a future.
  */
  final Completer<GoogleMapController> _controller = Completer();
  /*
    CameraPosition that represents the position and
    zoom level of the camera in a map view
  */

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(29.3981, 71.6908),
    zoom: 14,
  );

  List<Marker> _marker = [];
  final List<Marker> _list = [
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(29.3981, 71.6908),
      infoWindow: InfoWindow(
        title: 'My Current Location',
      ),
    ),
    const Marker(
      markerId: MarkerId('2'),
      position: LatLng(29.3889, 71.6808),
      infoWindow: InfoWindow(
        title: 'BVH',
      ),
    ),
    const Marker(
      markerId: MarkerId('3'),
      position: LatLng(29.4308, 71.6517),
      infoWindow: InfoWindow(
        title: 'mcdonald\'s',
      ),
    ),
    const Marker(
      markerId: MarkerId('4'),
      position: LatLng(35.6762, 139.6703),
      infoWindow: InfoWindow(
        title: 'Tokyo Japan',
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_marker),
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                // target: LatLng(35.6762, 139.6503),  // Tokyo Japan
                target: LatLng(29.3981, 71.6908),
              ),
            ),
          );
          setState(() {});
        },
        child: const Icon(
          Icons.location_disabled_outlined,
        ),
      ),
    );
  }
}
