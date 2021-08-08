import 'package:equatable/equatable.dart';
import 'package:sea_oil/networks/helpers/errors.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginProgress extends LoginState {}

class LoginFailure extends LoginState {
  const LoginFailure({
    required this.error,
  });

  final Errors error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure {error: $error}';
}

class LoginUserSuccess extends LoginState {}
