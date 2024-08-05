import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovej/service/auth_service.dart';
import 'Screen/sign_in_screen.dart';
import 'bloc/LoginBloc/login_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) {
          return LoginBloc();
        },
        child: const SignInScreen(),
      ),
    );
  }
}
