
import 'package:flutter/material.dart';

abstract class SignUpEvent {}

class SignUpTextChangeEvent extends SignUpEvent {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String storeType;
  final String otp;
  final BuildContext context;

  SignUpTextChangeEvent({
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.fullName,
    required this.storeType,
    required this.otp,
    required this.context,
  });
}


class SignUpSubmitBtnEvent extends SignUpEvent {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String storeType;
  final String otp;
  final BuildContext context;

  SignUpSubmitBtnEvent({
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.fullName,
    required this.storeType,
    required this.otp,
    required this.context,
  });
}


class OtpBtnEvent extends SignUpEvent {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String storeType;
  final String otp;
  final BuildContext context;

  OtpBtnEvent({
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.fullName,
    required this.storeType,
    required this.otp,
    required this.context,
  });
}

