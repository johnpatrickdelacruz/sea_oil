import 'package:equatable/equatable.dart';
import 'package:sea_oil/networks/model/stations.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationToLogin extends NavigationEvent {}

class NavigationToLanding extends NavigationEvent {
  const NavigationToLanding({this.station});

  final Station? station;

  @override
  List<Object> get props => [station!];

  @override
  String toString() => 'NavigationToLanding {station}';
}

class NavigationToSearch extends NavigationEvent {
  const NavigationToSearch({required this.stations});

  final List<Station> stations;

  @override
  List<Object> get props => [stations];

  @override
  String toString() => 'NavigationToSearch {station}';
}
