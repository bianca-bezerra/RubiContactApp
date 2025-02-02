// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps/models/contact_entity.dart';
import 'package:google_maps/models/place_entity.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GoogleMapSearchPlacesApi extends StatefulWidget {
  final Function(PlaceEntity) onSelect;

  const GoogleMapSearchPlacesApi({super.key, required this.onSelect});

  @override
  State<GoogleMapSearchPlacesApi> createState() =>
      _GoogleMapSearchPlacesApiState();
}

class _GoogleMapSearchPlacesApiState extends State<GoogleMapSearchPlacesApi> {
  final _controller = TextEditingController();
  final String _sessionToken = '1234567890';
  static final String? _placesApiKey = dotenv.env['GOOGLE_API_KEY'];
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$_placesApiKey&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      if (kDebugMode) {
        print('mydata');
        print(data);
      }
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Coordinates> getCoordinates(String placeId) async {
    String baseURL = 'https://maps.googleapis.com/maps/api/place/details/json';
    String request =
        '$baseURL?key=$_placesApiKey&sessiontoken=$_sessionToken&place_id=$placeId';

    try {
      var response = await http.get(Uri.parse(request));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var coordinates = data["result"]["geometry"]["location"];
        return Coordinates.fromString(
            "${coordinates["lat"]}, ${coordinates["lng"]}");
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Search places Api',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search your location here",
                focusColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: const Icon(Icons.map),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _placeList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    var coordinates =
                        await getCoordinates(_placeList[index]["place_id"]);

                    if (mounted) {
                      widget.onSelect(PlaceEntity(
                        name: _placeList[index]["description"],
                        address: coordinates,
                      ));

                      GoRouter.of(context).pop();
                    }
                  },
                  child: ListTile(
                    title: Text(_placeList[index]["description"]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
