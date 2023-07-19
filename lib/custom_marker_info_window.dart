import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  /*
  
  */
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final Set<Marker> _marker = {};
  final List<LatLng> _latlang = <LatLng>[
    const LatLng(29.3981, 71.6908),
    const LatLng(29.3889, 71.6808),
    const LatLng(29.395722, 71.683333),
    const LatLng(29.3730707, 71.6666226),
    const LatLng(29.4308, 71.6517),
    const LatLng(29.5467, 71.6276),
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < _latlang.length; i++) {
      _marker.add(
        Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: _latlang[i],
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://plus.unsplash.com/premium_photo-1676202363503-4f44c507bc60?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                            ),
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _latlang[i],
            );
          },
        ),
      );
      setState(() {});
    }
  }

  /*
  
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Custom Marker Info Window',
          style: TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(29.3981, 71.6908),
              zoom: 14,
            ),
            markers: _marker,
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 200,
            width: 300,
            offset: 35,
          ),
        ],
      ),
    );
  }
}
