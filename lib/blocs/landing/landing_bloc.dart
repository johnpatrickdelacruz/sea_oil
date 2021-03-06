import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sea_oil/blocs/landing/landing_event.dart';
import 'package:sea_oil/blocs/landing/landing_state.dart';
import 'package:sea_oil/networks/abstract_repositories/account_repository_providing.dart';
import 'package:sea_oil/networks/helpers/connectivity_helper.dart';
import 'package:sea_oil/networks/helpers/errors.dart';
import 'package:sea_oil/networks/model/stations.dart';
import 'package:sea_oil/networks/parsers/http_server_response.dart';

import 'package:sea_oil/networks/repositories/account_repository.dart';

import '../../locator.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  LandingBloc() : super(initialState);

  static LandingState get initialState => LandingInitial();

  final AccountRepositoryProviding _accountRepository =
      serviceLocator<AccountRepository>();

  List<Station> stationList = [];

  @override
  Stream<LandingState> mapEventToState(LandingEvent event) async* {
    if (event is LandingLoadSites) {
      if (stationList.length == 0) {
        yield* _mapLandingLoadSitesToState(
            context: event.context, station: event.station);
      } else {
        yield LandingSuccess(station: stationList, isLoaded: true);
      }
    } else if (event is BackToListStation) {
      yield LandingSuccess(station: stationList, isLoaded: true);
    } else if (event is SelectStation) {
      yield SelectStationSuccess(station: event.station);
    }
  }

  Stream<LandingState> _mapLandingLoadSitesToState(
      {required BuildContext context, Station? station}) async* {
    yield LandingProgress();
    HttpServerResponse response = new HttpServerResponse();

    if (!(await ConnectionHelper.hasConnection())) {
      yield LandingFailure(error: Errors.NoNetwork);
      return;
    }

    try {
      response = await _accountRepository.loadSites();

      Navigator.pop(context);

      stationList = response.data.stations;

      switch (response.status) {
        case 200:
          if (station != null) {
            yield SelectStationSuccess(station: station);
          } else {
            yield LandingSuccess(station: response.data.stations);
          }

          break;

        default:
          yield LandingFailure(error: Errors.Generic);
          break;
      }
    } catch (_) {
      Navigator.pop(context);
      yield LandingFailure(error: Errors.Generic);
    }
  }
}
