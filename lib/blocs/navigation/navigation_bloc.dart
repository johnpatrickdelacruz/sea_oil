import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sea_oil/blocs/navigation/navigation_event.dart';
import 'package:sea_oil/networks/base_classes/navigation_service.dart';
import 'package:sea_oil/views/router.dart';

import '../../locator.dart';

class NavigationBloc extends Bloc<NavigationEvent, dynamic> {
  NavigationBloc() : super(initialState);

  final NavigationService _navigationService =
      serviceLocator<NavigationService>();

  static int get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(NavigationEvent event) async* {
    if (event is NavigationToLogin) {
      _navigationService.navigateTo(Routes.login, false);
    }
    if (event is NavigationToLanding) {
      _navigationService.navigateTo(Routes.landing, false,
          arguments: event.station);
    }
    if (event is NavigationToSearch) {
      _navigationService.navigateTo(Routes.search, false,
          arguments: event.stations);
    }
  }
}
