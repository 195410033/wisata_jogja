import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wisata_jogja/models/objek_model.dart';
import 'package:wisata_jogja/providers/objek_provider.dart';
import 'package:wisata_jogja/services/objek_service.dart';
import 'package:wisata_jogja/theme.dart';
import 'package:wisata_jogja/providers/objek_provider.dart' as locations;

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({Key? key}) : super(key: key);
  // NearbyScreen(this.objek);
  // final ObjekModel objek;

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  BitmapDescriptor destinationMarker = BitmapDescriptor.defaultMarker;
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;

  // void setCustomMarker() async {
  //   try {
  //     destinationMarker = await BitmapDescriptor.fromAssetImage(
  //         const ImageConfiguration(devicePixelRatio: 2.0),
  //         "assets/icons/icon_flag.png");
  //   } catch (e) {
  //     // print("Error custom marker: " + e.toString());
  //   }
  // }

  // _getLocation() async {
  //   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //     target: LatLng(-7.79359812255, 110.404494703),
  //     zoom: 15,
  //     tilt: 80,
  //     bearing: 30,
  //   )));
  // }

  bool isTap = true;
  bool mapTap = false;
  bool pillTap = false;

  final CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(-7.79359812255, 110.404494703),
    zoom: 15,
    tilt: 80,
    bearing: 30,
  );

  search() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        left: defaultMargin,
        right: defaultMargin,
        top: 50,
      ),
      // padding: EdgeInsets.only(left: ),
      height: 45,
      decoration: BoxDecoration(
          border: Border.all(
            color: greyColor,
          ),
          color: tileColor,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: greyColor),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              // controller: searchController,
              maxLines: 1,
              onChanged: (value) {
                // handleSearch(value);
              },
              autofocus: false,
              keyboardType: TextInputType.text,
              style: greyTextStyle.copyWith(
                fontSize: 18,
                fontWeight: medium,
              ),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration.collapsed(
                hintText: 'Nama Wisata',
                hintStyle: greyTextStyle.copyWith(
                  fontSize: 15,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.filter_list,
              color: greyColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // final googleOffices = locations.ObjekProvider();

  final List<LatLng> _listLatLng = [
    const LatLng(
      -7.782940,
      110.367039,
    ),
    const LatLng(
      -7.793735,
      110.404484,
    ),
    const LatLng(
      -7.804058,
      110.3622737,
    ),
    const LatLng(
      -8.02425,
      110.3290573,
    ),
  ];

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.ObjekProvider();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.objek) {
        final marker = Marker(
            markerId: MarkerId(office.nama!),
            position: LatLng(office.ltd!, office.lngtd!),
            infoWindow: InfoWindow(
              title: office.nama!,
              snippet: office.category!.nama!,
            ),
            icon: BitmapDescriptor.defaultMarker);
        _markers[office.nama!] = marker;
      }
    });
  }

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(50, 50)),
            'assets/icons/icon_flag.png')
        .then((icon) {
      destinationMarker = icon;
    });
    // _getCurrentLocation();
    setState(() {});
    super.initState();
  }

// For storing the current position
  // Position? _currentPosition;
  // Method for retrieving the current location

//   _getCurrentLocation() async {
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) async {
//       setState(() {
//         // Store the position in the variable
//         _currentPosition = position;

//         print('CURRENT POS: $_currentPosition');

//         // For moving the camera to current location
//         mapController!.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(position.latitude, position.longitude),
//               zoom: 18.0,
//             ),
//           ),
//         );
//       });
//       await _getAddress();
//     }).catchError((e) {
//       print(e);
//     });
//   }

//   final startAddressController = TextEditingController();
// // Method for retrieving the address
//   String _currentAddress = '';
//   String _startAddress = '';
//   _getAddress() async {
//     try {
//       // Places are retrieved using the coordinates
//       List<Placemark> p = await placemarkFromCoordinates(
//           _currentPosition!.latitude, _currentPosition!.longitude);

//       // Taking the most probable result
//       Placemark place = p[0];

//       setState(() {
//         // Structuring the address
//         _currentAddress =
//             "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";

//         // Update the text of the TextField
//         startAddressController.text = _currentAddress;

//         // Setting the user's present location as the starting address
//         _startAddress = _currentAddress;
//       });

//       print(_currentAddress);
//     } catch (e) {
//       print(e);
//     }
//   }

  // loadData() {
  //   for (int i = 0; i < _listLatLng.length; i++) {
  //     _markers.add(
  //       Marker(
  //         markerId: MarkerId(i.toString()),
  //         position: _listLatLng[i],
  //         icon: BitmapDescriptor.defaultMarker,
  //         // infoWindow:
  //       ),
  //     );
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          // onMapCreated: _onMapCreated,

          mapToolbarEnabled: false,
          mapType: MapType.normal,
          // markers: _listLatLng != null
          //     ? _listLatLng.map((e) => listMarker(e)).toSet()
          //     : {},
          // markers: _markers.values.toSet(),
          markers: _listLatLng.map((e) => listMarker(e)).toSet(),
          // markers: Set<Marker>.of(_markers),
          // zoomControlsEnabled: false,
          // markers: _markers,
          myLocationEnabled: true,
          compassEnabled: false,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            // showPinsOnMap();
            setState(() {
              mapController = controller;
            });
          },
        ),
        // search(),
      ),
    );
  }

  Marker listMarker(LatLng e) {
    return Marker(
      markerId: MarkerId(e.hashCode.toString()),
      position: e,
      icon: destinationMarker,
      infoWindow: InfoWindow(
        //popup info
        title: '$e',
        snippet: 'My Custom Subtitle',
      ),
    );
  }
}
