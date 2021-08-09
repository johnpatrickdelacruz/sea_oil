import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sea_oil/networks/model/stations.dart';

abstract class LandingEvent extends Equatable {
  const LandingEvent();

  @override
  List<Object> get props => [];
}

class LandingLoadSites extends LandingEvent {
  const LandingLoadSites({required this.context, this.station});

  final BuildContext context;
  final Station? station;

  @override
  List<Object> get props => [context, station!];

  @override
  String toString() => 'LandingLoadSites {context}';
}

class SelectStation extends LandingEvent {
  const SelectStation({required this.station});

  final Station station;

  @override
  List<Object> get props => [station];

  @override
  String toString() => 'SelectStation {station}';
}

class BackToListStation extends LandingEvent {
  const BackToListStation({required this.stations});

  final List<Station> stations;

  @override
  List<Object> get props => [stations];

  @override
  String toString() => 'BackToListStation {station}';
}
