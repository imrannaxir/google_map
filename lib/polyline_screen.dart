import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  /*
  
  */
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(29.3981, 71.6908),
    zoom: 14,
  );

  final Set<Marker> _marker = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> latlng = [
    const LatLng(29.3981, 71.6908), // Current Location , Main Campus IUB
    // const LatLng(29.3977, 71.6903), // Old Campous IUB
    const LatLng(29.4066831305, 71.6785658907), // Khair Puri
    const LatLng(29.4308, 71.6517), // Mcdonald
    // const LatLng(29.3730707, 71.6666226), // Toll Plaza
    const LatLng(29.4564490584, 71.6426129912),
    const LatLng(29.4800, 71.6468), // Mushtarka Balochistan Hotel Lodhran

    // const LatLng(29.5467, 71.6276),        // Lodhran
  ];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < latlng.length; i++) {
      _marker.add(
        Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: latlng[i],
          infoWindow: const InfoWindow(
            title: 'Cool Place',
            snippet: '5 Star Rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      setState(() {});
      _polyline.add(
        Polyline(
          polylineId: const PolylineId('1'),
          points: latlng,
          color: Colors.pink,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Polyline'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: _marker,
          polylines: _polyline,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
