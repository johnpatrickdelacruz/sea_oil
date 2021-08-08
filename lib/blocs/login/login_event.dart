import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUser extends LoginEvent {
  const LoginUser(
      {required this.username, required this.password, required this.context});

  final String username;
  final String password;
  final BuildContext context;

  @override
  List<Object> get props => [username, password, context];

  @override
  String toString() => 'LoginUser {username: $username} {password: $password}';
}
