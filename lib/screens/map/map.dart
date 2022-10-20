import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/office.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart';

class locationMap extends StatefulWidget {
  const locationMap({super.key});

  @override
  State<locationMap> createState() => _locationMapState();
}

class _locationMapState extends State<locationMap> {
  final Map<String, Marker> _markers = {};
  final proLocations = offices;
  _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.clear();
      for (final location in proLocations) {
        Loc office = Loc(
            location['name'], location['address'], location['lat'], location['lng']);
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 14,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}
