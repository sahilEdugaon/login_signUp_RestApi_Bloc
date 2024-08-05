import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovej/utils/snack_bar.dart';
import 'package:pinput/pinput.dart';

import '../bloc/LoginBloc/login_bloc.dart';
import '../bloc/SignUpBloc/signUp_bloc.dart';
import '../bloc/SignUpBloc/sign_event.dart';
import '../bloc/SignUpBloc/signup_state.dart';
import '../utils/colors_constant.dart';
import '../utils/image_constant.dart';
import 'homeScreen.dart';

class VerifyCode extends StatefulWidget {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String storeType;
  const VerifyCode({super.key,required this.fullName, required this.email, required this.phoneNumber, required this.password, required this.storeType});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {

  final TextEditingController _pinController = TextEditingController();

  String? getOtp;
  bool _isResendAgain = false;
  late Timer _timer;
  int _start = 60;

  @override
  void initState() {
    // TODO: implement initState
    resend();
    _pinController.clear();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    SignUpBloc().close();
    _pinController.clear();
    super.dispose();
  }
  void resend() {
    setState(() {
      _isResendAgain = true;
    });

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _start = 60;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final defaultPinTheme = PinTheme(
      width: screenWidth / 7,
      height: screenHeight / 14,
      textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorsConstant.weddingGreyColor, width: 1.5),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorsConstant.pinkColor, width: 1.5),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: ColorsConstant.pinkColor,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: Colors.green, width: 1.5),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body:ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: screenWidth / 7.9,
                    height: screenHeight / 17,
                    padding: EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorsConstant.weddingGreyColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: ColorsConstant.pinkColor,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight / 7.5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageConstant.messageBox, height: screenHeight / 6),
              SizedBox(height: screenHeight / 22),
              Text(
                _isResendAgain?'$_start':'00:00',
                style: TextStyle(
                  fontSize: screenHeight / 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight / 90),
              Text(
                "Type the verification\ncode\n we've sent you",
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: screenHeight / 52,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                child: SizedBox(
                  child: Pinput(
                    controller: _pinController, // Add the controller
                    keyboardType: TextInputType.number,
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    showCursor: false,
                    preFilledWidget: const Text('0',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey, // Hint text color
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        getOtp= value??'0000';
                        print('ootp-$value');
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<SignUpBloc,SignUpState>(
                builder: (BuildContext context, state) {
                  return  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      height: 45,
                      margin: EdgeInsets.only(left: 50,right: 50),
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.transparent, // Set to transparent as the button will have its own color
                        boxShadow: [
                          BoxShadow(
                            color: ColorsConstant.pinkColor.withOpacity(0.3), // Shadow color
                            spreadRadius: 5, // Spread radius
                            blurRadius: 8, // Blur radius
                            offset: const Offset(2, 1.5), // Offset in the x and y direction
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsConstant.pinkColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0, // Remove the default elevation
                        ),
                        onPressed: () {
                          print('_pinController.text');
                          print(_pinController.text);
                          if(_pinController.text.length==6){
                            BlocProvider.of<SignUpBloc>(context).add(
                                OtpBtnEvent(
                                    fullName: widget.fullName,
                                    phoneNumber: widget.phoneNumber,
                                    email: widget.email,
                                    password: widget.password,
                                    otp:getOtp??"0000" ,
                                    storeType:widget.storeType ,
                                    context: context
                                )
                            );
                          }
                          else{
                            snackBar(context, 'Enter Valid Otp', Colors.white, Colors.red);
                          }
                        },
                        child:  Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              (state is SignUpLoadingState)
                                  ?const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: CircularProgressIndicator(color: Colors.white,),
                              )
                                  :Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: screenHeight / 12),
              BlocBuilder<SignUpBloc,SignUpState>(
                builder: (BuildContext context, state) {
                  return  TextButton(
                      onPressed: () {
                        if(_isResendAgain==false){
                          BlocProvider.of<SignUpBloc>(context).add(
                              SignUpSubmitBtnEvent(
                                  fullName: widget.fullName,
                                  phoneNumber: widget.phoneNumber,
                                  email: widget.email,
                                  password: widget.password,
                                  otp:"" ,
                                  storeType:"Fabric" ,
                                  context: context
                              )
                          );
                          resend();
                          _pinController.clear();
                        }
                      },
                      child: Text("Send again", style: TextStyle(color: ColorsConstant.pinkColor, fontSize: screenHeight/55, fontWeight: FontWeight.w700),));
                },
              ),
            ],
          ),
        ],
      ),
    );

  }
}
