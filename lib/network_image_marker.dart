import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkImageMarker extends StatefulWidget {
  const NetworkImageMarker({super.key});

  @override
  State<NetworkImageMarker> createState() => _NetworkImageMarkerState();
}

class _NetworkImageMarkerState extends State<NetworkImageMarker> {
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
    const LatLng(29.4066831305, 71.6785658907), // Khair Puri
    const LatLng(29.4308, 71.6517), // McDonald's
    const LatLng(29.4564490584, 71.6426129912), // BBQ Tonight
    const LatLng(29.4800, 71.6468), // Mushtarka Balochistan Hotel Lodhran
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < latlng.length; i++) {
      Uint8List? image = await loadNetworkImage(
        'https://cdn-icons-png.flaticon.com/128/2922/2922688.png',
      );

      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100,
      );

      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();

      _marker.add(
        Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: latlng[i],
          icon: BitmapDescriptor.fromBytes(resizedImageMarker),
          infoWindow: InfoWindow(
            title: 'Title of Marker ${i.toString()}',
          ),
        ),
      );
      setState(() {});
    }
  }

  Future<Uint8List?> loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);

    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, _) {
          completer.complete(info);
        },
      ),
    );

    final imageInfo = await completer.future;

    final byteData = await imageInfo.image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    return byteData!.buffer.asUint8List();
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
