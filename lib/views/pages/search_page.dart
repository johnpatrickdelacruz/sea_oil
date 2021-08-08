import 'package:flutter/material.dart';
import 'package:sea_oil/networks/model/stations.dart';
import 'package:sea_oil/views/widgets/search/search_screen.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key, required this.stationList}) : super(key: key);

  final List<Station> stationList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchScreen(stationList: stationList),
    );
  }
}
