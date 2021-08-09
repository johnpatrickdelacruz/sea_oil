import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sea_oil/blocs/landing/landing_bloc.dart';
import 'package:sea_oil/blocs/landing/landing_event.dart';

import 'package:sea_oil/blocs/landing/landing_state.dart';
import 'package:sea_oil/blocs/navigation/navigation_bloc.dart';
import 'package:sea_oil/blocs/navigation/navigation_event.dart';

import 'package:sea_oil/networks/model/stations.dart';
import 'package:sea_oil/views/generic/dialogs/generic_dialog.dart';
import 'package:sea_oil/views/widgets/app_bar.dart';
import 'package:sea_oil/views/widgets/app_text.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final searchController = TextEditingController();

  late GoogleMapController mapController;
  Set<Marker> _markers = {};

  var geoLocator = Geolocator();
  late Position currentPosition;
  late List<Station> station = [];

  bool isStationFromList = false;

  int selectedRadio = -1;

  late CameraPosition cp;

  static final CameraPosition initialLoc = CameraPosition(
    target: LatLng(14.5772133, 121.1261983),
    zoom: 18,
  );

  void setupPositionLocator() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentPosition = position;
    print("get current position");
    setCameraPosition(lat: position.latitude, long: currentPosition.longitude);
  }

  setCameraPosition({lat, long}) {
    LatLng pos = LatLng(lat, long);
    cp = new CameraPosition(target: pos, zoom: 18);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));

    Marker marker = Marker(
        markerId: MarkerId(''),
        position: pos,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        infoWindow: InfoWindow(snippet: 'Sea Oil'));

    setState(() {
      _markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LandingBloc, LandingState>(
      listener: (context, state) {
        if (state is LandingProgress) {
          GenericDialog.showLoadingDialog(context);
        } else if (state is LandingSuccess) {
          station = [];
          state.station.forEach((element) async {
            Future.delayed(Duration(seconds: state.isLoaded == null ? 1 : 0),
                () {
              double distance = Geolocator.distanceBetween(
                  currentPosition.latitude,
                  currentPosition.longitude,
                  double.parse(element.lat),
                  double.parse(element.lng));

              element.distance = distance;

              station.add(element);

              setState(() {
                station.sort((a, b) {
                  return a.distance!.compareTo(b.distance!);
                });
              });
            }).catchError((error) => throw Exception(error));
          });
        } else if (state is SelectStationSuccess) {
          setState(() {
            isStationFromList = true;
          });

          print(isStationFromList);
          print("SelectStationSuccess");

          LatLng location = new LatLng(
              double.parse(state.station.lat), double.parse(state.station.lng));

          print("set selected position");
          Future.delayed(Duration(seconds: 1), () {
            setCameraPosition(lat: location.latitude, long: location.longitude);
          }).catchError((error) => throw Exception(error));
          // setCameraPosition(lat: location.latitude, long: location.longitude);
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppbarWithTitle(
            title: 'SEA OIL MAP',
            actions: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<NavigationBloc>(context).add(
                    NavigationToSearch(stations: station),
                  );
                },
                child: Icon(
                  Icons.search,
                  color: Colors.purple,
                  size: 30.0,
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: initialLoc,
                  myLocationButtonEnabled: true,
                  markers: _markers,
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  padding: EdgeInsets.only(bottom: 0),
                  onMapCreated: (GoogleMapController controller) {
                    if (!_controller.isCompleted) {
                      _controller.complete(controller);
                      mapController = controller;
                    }

                    // if (searchStation == null) {
                    // print(isStationFromList);
                    // print("isStationFromList");
                    // if (!isStationFromList) {
                    setupPositionLocator();
                    // }

                    // }
                  }),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: BlocBuilder<LandingBloc, LandingState>(
                  builder: (context, state) {
                    if (state is SelectStationSuccess) {
                      return Container(
                        height: 260,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 15.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.7, 0.7))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    backToList();
                                  },
                                  child: AppText(
                                    fontSize: 18,
                                    text: 'Back to List',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                                AppText(
                                  fontSize: 18,
                                  text: 'Done',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            AppText(
                              fontSize: 16,
                              text: state.station.name,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 20),
                            AppText(text: state.station.address),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(
                                  Icons.car_repair,
                                  color: Colors.purple,
                                ),
                                AppText(
                                    text: (state.station.distance! / 1000)
                                            .toStringAsFixed(0) +
                                        ' km away'),
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Icon(
                                    Icons.history,
                                    color: Colors.purple,
                                  ),
                                ),
                                AppText(text: ('Open 24 hours ')),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    }

                    return Container(
                      height: 260,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 15.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7))
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nearby Stations',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Done',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black45),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 180,
                            child: ListView.builder(
                              itemCount: station.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  trailing: Radio(
                                    value: index,
                                    groupValue: selectedRadio,
                                    onChanged: (val) {
                                      selectedStation(
                                          index: int.parse(val.toString()));
                                    },
                                  ),
                                  onTap: () {
                                    selectedStation(index: index);
                                  },
                                  title: Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: AppText(
                                      text: station[index].address,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle: Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: AppText(
                                        text: (station[index].distance! / 1000)
                                                .toStringAsFixed(0) +
                                            ' km away from you'),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void backToList() {
    BlocProvider.of<LandingBloc>(context).add(
      BackToListStation(stations: station),
    );
  }

  void selectedStation({required int index}) {
    setState(() {
      selectedRadio = index;
    });

    BlocProvider.of<LandingBloc>(context).add(
      SelectStation(station: station[index]),
    );
  }
}
