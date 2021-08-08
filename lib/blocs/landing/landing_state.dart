import 'package:equatable/equatable.dart';
import 'package:sea_oil/networks/helpers/errors.dart';
import 'package:sea_oil/networks/model/stations.dart';

abstract class LandingState extends Equatable {
  const LandingState();

  @override
  List<Object> get props => [];
}

class LandingInitial extends LandingState {}

class LandingProgress extends LandingState {}

class LandingFailure extends LandingState {
  const LandingFailure({
    required this.error,
  });

  final Errors error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LandingFailure {error: $error}';
}

class LandingSuccess extends LandingState {
  const LandingSuccess({
    required this.station,
  });

  final List<Station> station;

  @override
  List<Object> get props => [station];

  @override
  String toString() => 'LandingSuccess {station: $station}';
}

class SelectStationSuccess extends LandingState {
  const SelectStationSuccess({
    required this.station,
  });

  final Station station;

  @override
  List<Object> get props => [station];

  @override
  String toString() => 'SelectStation {station: $station}';
}

class SearchStationPage extends LandingState {
  const SearchStationPage({
    required this.station,
  });

  final List<Station> station;

  @override
  List<Object> get props => [station];

  @override
  String toString() => 'SearchStationPage {station: $station}';
}
