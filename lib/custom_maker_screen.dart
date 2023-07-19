import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMakerScreen extends StatefulWidget {
  const CustomMakerScreen({super.key});

  @override
  State<CustomMakerScreen> createState() => _CustomMakerScreenState();
}

class _CustomMakerScreenState extends State<CustomMakerScreen> {
  /*
  
  */
  final Completer<GoogleMapController> _controller = Completer();

  Uint8List? markerImage;

  List<String> images = [
    'assets/images/car.png',
    'assets/images/location.png',
    'assets/images/map.png',
    'assets/images/marker.png',
    'assets/images/restaurant.png',
    'assets/images/motorbike.png',
  ];

  final List<Marker> _marker = <Marker>[];
  final List<LatLng> _latlang = <LatLng>[
    const LatLng(29.3981, 71.6908),
    const LatLng(29.3889, 71.6808),
    const LatLng(29.395722, 71.683333),
    const LatLng(29.3730707, 71.6666226),
    const LatLng(29.4308, 71.6517),
    const LatLng(29.5467, 71.6276),
  ];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(29.3981, 71.6908),
    zoom: 14,
  );

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);

    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: width,
    );
    ui.FrameInfo info = await codec.getNextFrame();

    return (await info.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      _marker.add(
        Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: _latlang[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: 'This is title marker : ${i.toString()}',
          ),
        ),
      );
      setState(() {});
    }
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
          markers: Set<Marker>.of(_marker),
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
