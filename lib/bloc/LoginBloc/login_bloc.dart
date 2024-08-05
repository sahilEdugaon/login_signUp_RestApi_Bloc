
import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovej/bloc/LoginBloc/login_event.dart';
import 'package:lovej/bloc/LoginBloc/login_state.dart';
import 'package:lovej/utils/snack_bar.dart';

import '../../Screen/homeScreen.dart';
import '../../service/auth_service.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc():super(LoginInitializeState()){
    on<LoginTextChangeEvent>((event, emit){

      print('EmailValidator-${EmailValidator.validate(event.email)}');

      if(EmailValidator.validate(event.email)==false){
        emit(LoginErrorState('Please Enter Valid Email Address'));
      }
      else if(event.password.length < 6){
        emit(LoginErrorState('Please Enter Valid Password'));
      }
      else{
        emit(LoginValid());
      }
    });

    on<LoginSubmitBtnEvent>((event, emit) {
      emit(LoginLoadingState());
      loginLogic(event.email,event.password,event.role,event.deviceToken,event.context);

    });

  }

  loginLogic(String email, String password,String role, String deviceToken, BuildContext context)async{
    emit(LoginLoadingState());
    final Map<String,dynamic> data = {
      "email":email,
      "password":password,
      "role":role,
      "storeType":"Fabric",
    };
    await AuthService().loginService(data,context).then((response){
      emit(LoginLoadingState());

      final responseBody = json.decode(response?.body??"");

      print('responseBody-$responseBody');

      if (responseBody['success'] == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
        );
        snackBar(context, 'Login successfully!', Colors.white, Colors.green);
      }
      else {
        // emit(LoginErrorState(responseBody['message']));
        //
        print('LoginErrorState-${responseBody['message']}');
        snackBar(context, responseBody['message'], Colors.white, Colors.red);

      }
    })
        .onError((error, stackTrace){
       emit(LoginErrorState('$error'));
      //snackBar(context, 'Login failed!', Colors.white, Colors.red);

    });
  }

}
