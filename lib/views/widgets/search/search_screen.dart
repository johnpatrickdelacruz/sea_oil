import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sea_oil/blocs/landing/landing_bloc.dart';

import 'package:sea_oil/blocs/landing/landing_state.dart';
import 'package:sea_oil/blocs/navigation/navigation_bloc.dart';
import 'package:sea_oil/blocs/navigation/navigation_event.dart';

import 'package:sea_oil/networks/model/stations.dart';
import 'package:sea_oil/views/widgets/app_bar.dart';

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
            appBar: AppbarWithTitle(
              title: 'Search Location',
              actions: Padding(
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
              ),
            ),
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: SafeArea(
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: newStationList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            BlocProvider.of<NavigationBloc>(context).add(
                              NavigationToLanding(
                                  station: newStationList[index]),
                            );
                          },
                          title: Container(
                            padding: EdgeInsets.only(top: 15),
                            child: AppText(
                                text: newStationList[index].address,
                                color: Colors.black),
                          ),
                          subtitle: Container(
                            padding: EdgeInsets.only(top: 5),
                            child: AppText(
                                text: (newStationList[index].distance! / 1000)
                                        .toStringAsFixed(0) +
                                    ' km away from you'),
                          ),
                        );
                      },
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

  void onSearchTextChanged(String text) async {
    newStationList = [];

    widget.stationList.forEach((element) {
      if (element.address.toLowerCase().contains(text.toLowerCase()))
        newStationList.add(element);
    });

    setState(() {
      if (text.length == 0) {
        newStationList.addAll(widget.stationList);
      }
    });
  }
}
