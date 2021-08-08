import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sea_oil/blocs/landing/landing_bloc.dart';
import 'package:sea_oil/blocs/landing/landing_event.dart';

import 'package:sea_oil/blocs/landing/landing_state.dart';
import 'package:sea_oil/blocs/navigation/navigation_bloc.dart';
import 'package:sea_oil/blocs/navigation/navigation_event.dart';

import 'package:sea_oil/networks/model/stations.dart';

import 'package:sea_oil/views/widgets/app_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.stationList}) : super(key: key);

  final List<Station> stationList;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  late List<Station> newStationList = [];

  @override
  void initState() {
    super.initState();

    newStationList.addAll(widget.stationList);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: BlocBuilder<LandingBloc, LandingState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: AppText(text: 'Search Location', color: Colors.purple),
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.purple),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<NavigationBloc>(context).add(
                        NavigationToLanding(),
                      );
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.purple,
                      size: 30.0,
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                height: size.height * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: TextField(
                            controller: searchController,
                            onChanged: onSearchTextChanged,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Search'),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: size.height * 0.65,
                      child: ListView.builder(
                        itemCount: newStationList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            trailing: Radio(
                              value: "N",
                              groupValue: newStationList[index],
                              onChanged: (val) {
                                setState(() {});
                              },
                            ),
                            onTap: () {
                              BlocProvider.of<NavigationBloc>(context).add(
                                NavigationToLanding(
                                    station: newStationList[index]),
                              );
                            },
                            title: AppText(
                              text: newStationList[index].address,
                              color: Colors.black54,
                            ),
                            subtitle: Container(
                              padding: EdgeInsets.only(top: 10),
                              child: AppText(
                                  text: (newStationList[index].distance! / 1000)
                                          .toStringAsFixed(0) +
                                      ' km away from you'),
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
        },
      ),
    );
  }

  void onSearchTextChanged(String value) {
    setState(() {
      newStationList = newStationList
          .where((element) =>
              element.address.toLowerCase().contains(value.toLowerCase()))
          .toList();

      if (value.length == 0) {
        newStationList = widget.stationList;
      }
    });
  }
}
