import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({super.key});

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {
  /*
  
  */

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(29.3981, 71.6908),
    zoom: 14,
  );

  final List<Marker> _marker = <Marker>[
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(29.3981, 71.6908),
      infoWindow: InfoWindow(
        title: 'My Current Location',
      ),
    ),
  ];

  Future<Position> userCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError(
      (error, stackTrace) {
        print('Error $error');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error $error',
            ),
          ),
        );
      },
    );
    return await Geolocator.getCurrentPosition();
  }

  loadData() {
    userCurrentLocation().then((value) async {
      print(
        "My Current Location is : ${value.latitude.toString()} : ${value.longitude.toString()}",
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "My Current Location is : ${value.latitude.toString()} & ${value.longitude.toString()}",
          ),
        ),
      );

      _marker.add(
        Marker(
            markerId: const MarkerId('2'),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: const InfoWindow(
              title: 'My Current Location',
            )),
      );

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
      );

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // loadData();
        },
        child: const Icon(
          Icons.local_activity,
        ),
      ),
    );
  }
}
