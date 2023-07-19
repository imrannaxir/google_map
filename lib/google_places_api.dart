import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApi extends StatefulWidget {
  const GooglePlacesApi({super.key});

  @override
  State<GooglePlacesApi> createState() => _GooglePlacesApiState();
}

class _GooglePlacesApiState extends State<GooglePlacesApi> {
  /*
   
  */
  final TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  var sessionToken = '11223344';

  List<dynamic> _placesList = [];

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      onChanged();
    });
  }

  void onChanged() {
    if (sessionToken == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    }

    getSuggesion(_controller.text);
  }

  void getSuggesion(String input) async {
    String kPLACES_API_KEY = 'AIzaSyAevrBN7KC0n6BmfPjIMcD0bfHFlFlrfio';

    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();

    print('Data $data');

    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to Load Data');
    }
  }

  /*
   
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Google Places Api',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search Places Apis :',
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _placesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _placesList[index]['description'],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
