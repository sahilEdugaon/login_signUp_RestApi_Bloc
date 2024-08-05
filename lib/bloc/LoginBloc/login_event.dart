
import 'package:flutter/material.dart';

abstract class LoginEvent {}

class LoginTextChangeEvent extends LoginEvent {
  final String email;
  final String password;
  LoginTextChangeEvent({
    required this.email,
    required this.password,
  });
}


class LoginSubmitBtnEvent extends LoginEvent {
  final String email;
  final String password;
  final String role;
  final String deviceToken;
  final BuildContext context;
  LoginSubmitBtnEvent({
    required this.email,
    required this.password,
    required this.role,
    required this.deviceToken,
    required this.context,
  });
}

