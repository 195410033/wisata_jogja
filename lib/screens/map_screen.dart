import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:wisata_jogja/theme.dart';

const double pinInvisible = -200;
const double pinVisible = 20;

class MapScreen extends StatefulWidget {
  double desLat;
  double desLon;
  double souLat;
  double souLon;
  String place;

  MapScreen({
    Key? key,
    this.souLat = 0.0,
    this.souLon = 0.0,
    required this.desLat,
    required this.desLon,
    required this.place,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> _markers = Set<Marker>();
  late BitmapDescriptor sourceMarker;
  late BitmapDescriptor destinationMarker;
  final Completer<GoogleMapController> _controller = Completer();

  String apiKey = "AIzaSyBh7bJ1yGCHZIH4oA8h2S12bEGtNnBeQgE";

  void setCustomMarker() async {
    try {
      sourceMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.0),
          "assets/icons/icon_person.png");
      destinationMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.0),
          "assets/icons/icon_flag.png");
    } catch (e) {
      print("Error custom marker: " + e.toString());
    }
  }

  bool isTap = true;
  bool mapTap = false;
  bool pillTap = false;

  final Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polyLineCoordinates = [];
  late PolylinePoints polylinePoints;
  GoogleMapController? mapController;

  _getLocation() async {
    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(widget.souLat, widget.souLon),
      zoom: 15,
      tilt: 80,
      bearing: 30,
    )));
  }

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    setCustomMarker();
    print(widget.souLat);
    print(widget.souLon);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(widget.desLat, widget.desLon),
      zoom: 16,
      tilt: 80,
      bearing: 30,
    );

    String place = widget.place;

    return Scaffold(
      body: Stack(alignment: AlignmentDirectional.topCenter, children: [
        GoogleMap(
          polylines: _polylines,
          mapType: MapType.normal,
          compassEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            showPinsOnMap();
            setPolyLines();
            setState(() {
              mapController = controller;
            });
          },
          onTap: (LatLng loc) {
            setState(() {
              mapTap = false;
            });
          },
          markers: _markers,
          initialCameraPosition: initialCameraPosition,
        ),
        SafeArea(
          child: GestureDetector(
            onTap: () {
              _getLocation();
              setState(() {});
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 70,
              width: size.width / 1.2,
              decoration: BoxDecoration(
                color: isTap
                    ? Colors.white.withOpacity(0.7)
                    : orangeColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(50),
                boxShadow: kBoxShadows,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 45,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    "Lokasi Saya",
                    style: blackTextStyle,
                  ),
                  Spacer(),
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        shape: BoxShape.circle),
                    child: Image.asset(
                      "assets/icons/icon_person.png",
                      color: greyColor,
                      height: 30,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          bottom: mapTap ? pinVisible : pinInvisible,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 70,
            width: size.width / 1.2,
            decoration: BoxDecoration(
                color: pillTap
                    ? Colors.green.withOpacity(0.7)
                    : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(50),
                boxShadow: kBoxShadows),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.travel_explore,
                  size: 45,
                ),
                Text(
                  place,
                  style: blackTextStyle,
                ),
                Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Image.asset(
                    "assets/icons/icon_flag.png",
                    height: 30,
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void showPinsOnMap() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId("source-1"),
          position: LatLng(widget.souLat, widget.souLon),
          icon: sourceMarker,
          onTap: () {
            isTap = !isTap;
            setState(() {});
          }));

      _markers.add(Marker(
          markerId: MarkerId("destination-1"),
          position: LatLng(widget.desLat, widget.desLon),
          icon: destinationMarker,
          onTap: () {
            setState(() {
              mapTap = true;
              pillTap = true;
              isTap = true;
            });
          }));
    });
  }

  void setPolyLines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(widget.souLat, widget.souLon),
        PointLatLng(widget.desLat, widget.desLon));
    print(result.status);
    print(result.points);
    if (result.status == "OK") {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {
        _polylines.add(Polyline(
            polylineId: PolylineId("polyline"),
            width: 10,
            points: polyLineCoordinates,
            color: Colors.blue));
      });
    } else {
      print('tidak dapat cetak polylines');
    }
  }
}
