import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:lovej/Screen/verify_code.dart';
import 'package:lovej/bloc/SignUpBloc/sign_event.dart';
import 'package:lovej/bloc/SignUpBloc/signup_state.dart';

import '../../Screen/homeScreen.dart';
import '../../service/auth_service.dart';
import '../../utils/snack_bar.dart';
import '../LoginBloc/login_event.dart';
import '../LoginBloc/login_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitializeState()) {
    on<SignUpTextChangeEvent>((event, emit) {
      print('EmailValidator-${EmailValidator.validate(event.email)}');

       if (event.fullName.length < 5) {
        emit(SignUpErrorState('Please Enter fullName'));
      } else if (event.email.isEmpty) {
         emit(SignUpErrorState('Please Enter Email Address'));
       }
       else if (EmailValidator.validate(event.email) == false) {
        emit(SignUpErrorState('Please Enter Valid Email Address'));
      }
      else if (event.phoneNumber.length < 10) {
        emit(SignUpErrorState('Please Enter Mobile Number'));
      }
      else if (event.phoneNumber.length > 10) {
        emit(SignUpErrorState('Please Enter Valid Mobile Number'));
      }
      else if (event.password.isEmpty) {
        emit(SignUpErrorState('Please Enter Password'));
      }
      else if (event.password.length < 6) {
        emit(SignUpErrorState('Password must be at least 6 characters'));
      }
      else {
        emit(SignUpValid());
      }
    });

    on<SignUpSubmitBtnEvent>((event, emit) {
      emit(SignUpLoadingState());
      sentOpt(event.email, event.password, event.phoneNumber, event.fullName,
          event.otp, event.storeType, event.context);
    });

    on<OtpBtnEvent>((event, emit) {
      emit(SignUpLoadingState());
      signUp(event.email, event.password, event.phoneNumber, event.fullName,
          event.otp, event.storeType, event.context);
    });
  }

  signUp(String email, String password, String phoneNumber, String fullName,
      String otp, String storeKey, BuildContext context) async {
    emit(SignUpLoadingState());
    final Map<String, dynamic> data = {
      "email": email,
      "password": password,
      "name": fullName,
      "otp_key": otp,
      "storeType": storeKey,
      "mobileNumber": phoneNumber,
    };
    await AuthService().createAccountService(data,context).then((response) {
      emit(SignUpLoadingState());

      final responseBody = json.decode(response?.body??"");

      print('responseBody-$responseBody');

      if (responseBody['success'] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        snackBar(context, responseBody['message'], Colors.white, Colors.green);
      }
      else {
        // emit(LoginErrorState(responseBody['message']));
        //
        print('LoginErrorState-${responseBody['message']}');
        snackBar(context, responseBody['message'], Colors.white, Colors.red);
      }
    })
        .onError((error, stackTrace) {
       emit(SignUpErrorState('$error'));
      print('onError');
      print(error);
      // snackBar(context, '$error', Colors.white, Colors.red);
       if (error is http.Response) {
         final errorResponseBody = json.decode(error.body ?? "");
         print('Error responseBody-${errorResponseBody['message']}');
         snackBar(context, errorResponseBody['message'], Colors.white, Colors.red);
       }
    });
  }

  sentOpt(String email, String password, String phoneNumber, String fullName,
      String otp, String storeKey, BuildContext context) async {
    print('sentOpt');
    emit(SignUpLoadingState());
    final Map<String, dynamic> data = {
      "email": email.trim(),
    };
    await AuthService().otpService(data).then((response) {
      emit(SignUpLoadingState());

      final responseBody = json.decode(response?.body??"");

      print('responseBody-$responseBody');

      if (responseBody['success'] == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => SignUpBloc(),
                child: VerifyCode(
                  storeType: storeKey,
                  fullName: fullName,
                  email: email,
                  phoneNumber: phoneNumber,
                  password: password,
                ),
              ),
            ));
        snackBar(context, responseBody['message'], Colors.white, Colors.green);
        //emit(SignUpErrorState(''));
      } else {
        // emit(LoginErrorState(responseBody['message']));
        //
        print('LoginErrorState-${responseBody['message']}');
        snackBar(context, responseBody['message'], Colors.white, Colors.red);
      }
    }).onError((error, stackTrace) {
      emit(SignUpLoadingState());
      snackBar(context, 'Otp Sent failed!', Colors.white, Colors.red);
    });
  }
}
