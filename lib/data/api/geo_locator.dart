import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GetLatLong extends StatefulWidget {
  const GetLatLong({Key? key}) : super(key: key);

  @override
  State<GetLatLong> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLatLong> {
  Future<void> _openMap(String longitude, String latitude) async {
    String current_location_url =
        'https://maps.google.com/?q=$longitude,$latitude';
    if (await canLaunchUrlString(current_location_url)) {
      await launchUrlString(current_location_url);
    } else {
      throw "Can't launch $current_location_url";
    }
    print('=================================');
    print(current_location_url);
  }

  late String locationMessage = 'Current Location of User';
  late String long = '';
  late String lat = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(locationMessage),
          SizedBox(height: 20),
          Text('Latitude: $lat'),
          Text('Longitude: $long'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _getCurrentLocation().then((value) {
                setState(() {
                  lat = '${value.latitude}';
                  long = '${value.longitude}';
                });
              });
            },
            child: Text('Get Location'),
          ),
          ElevatedButton(
            onPressed: () {
              _openMap(lat, long);
            },
            child: Text('Open Location in Maps'),
          ),
        ],
      ),
    );
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }
    return await Geolocator.getCurrentPosition();
  }
}
