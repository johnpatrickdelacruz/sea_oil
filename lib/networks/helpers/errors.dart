import '../../values/strings.dart' as strings;

enum Errors {
  Generic,
  NoNetwork,
  UserNotRegistered,
}

extension ErrorExtension on Errors {
  String get errorMessage {
    switch (this) {
      case Errors.Generic:
        return strings.errorGeneric;
      case Errors.NoNetwork:
        return strings.errorNoInternet;
      case Errors.UserNotRegistered:
        return strings.errorNoInternet;

      default:
        return strings.errorGeneric;
    }
  }
}
