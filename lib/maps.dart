import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/office.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapState();
}

class _MapState extends State<MapWidget> {
  List offices = [
    {
      'name': 'Ntale John',
      'location': 'Wandegeya',
      'lat': 0.333754,
      'lng': 32.568383
    },
    {
      'name': 'Matovu Eric',
      'location': 'Kikoni',
      'lat': 0.342714,
      'lng': 32.561313
    },
    {
      'name': 'Kasozi Mark',
      'location': 'Mukono',
      'lat': 0.354866,
      'lng': 32.752014
    },
    {
      'name': 'Amanya Ela',
      'location': 'Kampala',
      'lat': 0.347596,
      'lng': 32.58252
    },
    {
      'name': 'Nalwoga Suzan',
      'location': 'Zzana',
      'lat': 0.262405,
      'lng': 32.557072
    },
    {
      'name': 'Kukunda Angella',
      'location': 'Seguku',
      'lat': 0.237516,
      'lng': 32.541173
    },
    {
      'name': 'Kyosaba Jeane',
      'location': 'Nakawa',
      'lat': 0.33846,
      'lng': 32.628731
    },
    {
      'name': 'Mubiru Nicholas',
      'location': 'Kyambogo',
      'lat': 0.346537,
      'lng': 32.628731
    },
    {
      'name': 'Tumusiime Welch',
      'location': 'Luzira',
      'lat': 0.296795,
      'lng': 32.646113
    },
  ];

  List<Office> officeObjects = [];

  createOffices() {
    for (var office in offices) {
      var newOffice = Office(
          office['name'], office['location'], office['lat'], office['lng']);
      officeObjects.add(newOffice);
    }
  }

  final Map<String, Marker> _markers = {};

  @override
  void initstate() {
    super.initState();
    createOffices();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      for (final office in officeObjects) {
        final marker = Marker(
            markerId: MarkerId(office.name),
            position: LatLng(office.lat, office.lng),
            infoWindow: InfoWindow(
              title: office.name,
              snippet: office.location,
            ));
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Coverage'),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition:
              const CameraPosition(target: LatLng(0.347596, 32.58252), zoom: 2),
          markers: _markers.values.toSet(),
        ));
  }
}
