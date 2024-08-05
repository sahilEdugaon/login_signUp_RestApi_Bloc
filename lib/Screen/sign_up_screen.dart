import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lovej/Screen/sign_in_screen.dart';
import 'package:lovej/bloc/LoginBloc/login_bloc.dart';
import 'package:lovej/bloc/SignUpBloc/signUp_bloc.dart';
import 'package:lovej/bloc/SignUpBloc/signup_state.dart';

import '../bloc/SignUpBloc/sign_event.dart';
import '../utils/colors_constant.dart';
import '../utils/image_constant.dart';
import '../utils/snack_bar.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // String? selectedValue;
  String? selectedValue = "Select";
  List<String> items = ["Select","Admin", "Designer"];
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNuController = TextEditingController();

  bool _isChecked = false;

  String _countryCode = "+91"; // Default country code

  @override
  void dispose() {
    // TODO: implement dispose
    SignUpBloc().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration:  BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(image: AssetImage(ImageConstant.phoneBg),
                    fit: BoxFit.fill,opacity: 0.18,
                    colorFilter:  ColorFilter.mode(Colors.grey[100]!,BlendMode.colorBurn)
                )
            ),
          ),

          ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
                width: screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight / 55,),
                    //Center(child: Text("LovoJ",style: GoogleFonts.barlow(textStyle: TextStyle( fontSize: screenHeight / 18, fontWeight: FontWeight.w600)))),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'L',
                              style: GoogleFonts.merriweather(
                                textStyle: TextStyle(
                                  fontSize: screenHeight / 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: 'o',
                              style: GoogleFonts.merriweather(
                                textStyle: TextStyle(
                                  fontSize: screenHeight / 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: 'v',
                              style: GoogleFonts.merriweather(
                                textStyle: TextStyle(
                                  fontSize: screenHeight / 18,
                                  fontWeight: FontWeight.w600,
                                  color: ColorsConstant.pinkColor,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: 'o',
                              style: GoogleFonts.merriweather(
                                textStyle: TextStyle(
                                  fontSize: screenHeight / 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: 'J',
                              style: GoogleFonts.merriweather(
                                textStyle: TextStyle(
                                  fontSize: screenHeight / 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
                height: screenHeight / 1.3,
                width: screenWidth,
                child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: screenHeight/30,
                        child: Container(
                          width: screenWidth/1.15 ,
                          height: screenHeight/1.38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: ColorsConstant.weddingGreyColor, width: 1.7),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.05), // Shadow color
                                spreadRadius: 5, // Spread radius
                                blurRadius: 5, // Blur radius
                                offset: Offset(0, 3), // Offset in the x and y direction
                              ),
                            ],
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: screenHeight /80,),
                                      Text("Designer", style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: screenHeight/25, fontWeight: FontWeight.w600),)),
                                      Text("Welcome Back!", style: TextStyle(fontSize: screenWidth/18, fontWeight: FontWeight.w500),),
                                      SizedBox(height: screenHeight/60,),
                                      BlocBuilder<SignUpBloc,SignUpState>(
                                        builder: (BuildContext context, state) {
                                          if(state is SignUpErrorState){
                                            return  Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Text(state.errorMessage,style: const TextStyle(color: Colors.red)),
                                                ),
                                              ],
                                            );
                                          }
                                          else{
                                            return  Container();
                                          }

                                        },
                                      ),
                                      TextField(
                                        controller: _fullNameController,
                                        onChanged: (value){
                                          BlocProvider.of<SignUpBloc>(context).add(
                                              SignUpTextChangeEvent(email: _emailController.text, password: _passwordController.text, phoneNumber: _phoneNuController.text, fullName: _fullNameController.text, storeType: '', otp: '', context: context)
                                          );
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                          hintText: "Full Name",
                                          hintStyle: TextStyle(fontSize: screenHeight/55),
                                          focusedBorder:  OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(color: ColorsConstant.pinkColor,width: 1.5),
                                          ),

                                        ),

                                      ),
                                      SizedBox(height: screenHeight/50,),

                                      TextField(
                                        controller: _emailController,
                                        onChanged: (value){
                                          BlocProvider.of<SignUpBloc>(context).add(
                                              SignUpTextChangeEvent(email: _emailController.text, password: _passwordController.text, phoneNumber: _phoneNuController.text, fullName: _fullNameController.text, storeType: '', otp: '', context: context)
                                          );
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                          hintText: "Enter Your Email",
                                          hintStyle: TextStyle(fontSize: screenHeight/55),
                                          focusedBorder:  OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(color: ColorsConstant.pinkColor,width: 1.5),
                                          ),

                                        ),
                                      ),
                                      SizedBox(height: screenHeight/50,),
                                      IntlPhoneField(
                                        controller:_phoneNuController ,
                                        flagsButtonPadding: const EdgeInsets.only(left: 5),
                                        dropdownTextStyle: TextStyle(fontSize: screenHeight/55),
                                        dropdownIconPosition: IconPosition.trailing,
                                        dropdownIcon: Icon(Icons.arrow_drop_down_sharp, size: screenHeight/40,),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                                          alignLabelWithHint: EditableText.debugDeterministicCursor,
                                          hintText: 'Mobile Number',
                                          hintStyle: TextStyle(fontSize: screenHeight/55),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                          focusedBorder:  OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(color: ColorsConstant.pinkColor,width: 1.5),
                                          ),
                                        ),
                                        initialCountryCode: 'IN',
                                        disableLengthCheck: true,
                                        textAlign: TextAlign.left,
                                        //textInputAction: TextInputAction.continueAction,
                                        onChanged: (phone){
                                          print('phone.completeNumber');
                                          print(phone.completeNumber);
                                          BlocProvider.of<SignUpBloc>(context).add(
                                              SignUpTextChangeEvent(email: _emailController.text, password: _passwordController.text, phoneNumber: _phoneNuController.text, fullName: _fullNameController.text, storeType: '', otp: '', context: context)
                                          );
                                        },
                                      ),

                                      SizedBox(height: screenHeight/50,),
                                      TextField(
                                        controller: _passwordController,
                                        onChanged: (value){
                                          BlocProvider.of<SignUpBloc>(context).add(
                                              SignUpTextChangeEvent(email: _emailController.text, password: _passwordController.text, phoneNumber: _phoneNuController.text, fullName: _fullNameController.text, storeType: '', otp: '', context: context)
                                          );
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                          hintText: "Enter Your Password",
                                          hintStyle: TextStyle(fontSize: screenHeight/55),
                                          suffixIcon: Icon(Icons.remove_red_eye_outlined, size: screenHeight/38,),
                                          focusedBorder:  OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(color: ColorsConstant.pinkColor,width: 1.5),
                                          ),

                                        ),

                                      ),
                                      SizedBox(height: screenHeight/90,),
                                      Row(
                                        children: [
                                          Image.asset(ImageConstant.iButton, color: ColorsConstant.pinkColor, height: screenHeight/70,),
                                          SizedBox(width: screenWidth/90,),
                                          InkWell(
                                              onTap: () {

                                              },
                                              child: Text("Passwords must be at least 6 characters.", style: TextStyle( fontWeight: FontWeight.w600, fontSize: screenHeight/70),))
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _isChecked = !_isChecked;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: ColorsConstant.pinkColor, // Outline color
                                                    width: 1.5, // Outline width
                                                  ),
                                                  borderRadius: BorderRadius.circular(3.0),
                                                ),
                                                child: Container(
                                                  width: screenWidth/25,
                                                  height: screenHeight/50,
                                                  color: _isChecked ? Colors.white : Colors.transparent,
                                                  child: _isChecked
                                                      ? Icon(
                                                    Icons.check,
                                                    size: screenHeight/50,
                                                    color: ColorsConstant.pinkColor,
                                                  )
                                                      : null,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: screenWidth/50,),
                                            Text('I accept the Terms and Conditions', style: TextStyle(fontSize: screenHeight/70, fontWeight: FontWeight.w500),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: screenHeight/95,),
                                      BlocBuilder<SignUpBloc,SignUpState>(
                                        builder: (BuildContext context, state) {
                                          return  Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 0),
                                            child: Container(
                                              height: screenHeight / 16,
                                              width: double.infinity,
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
                                                  if(
                                                  _emailController.text.isEmpty &&
                                                  _fullNameController.text.isEmpty &&
                                                  _phoneNuController.text.isEmpty &&
                                                      _passwordController.text.isEmpty){
                                                    snackBar(context, 'Please Enter All Filed', Colors.white, Colors.red);
                                                  }else if(_isChecked==false){
                                                    snackBar(context, 'Please Accept Term and Condition', Colors.white, Colors.red);
                                                  }
                                                  else{
                                                    print('state-');
                                                    print(state);
                                                    if(state is SignUpValid){
                                                      BlocProvider.of<SignUpBloc>(context).add(
                                                          SignUpSubmitBtnEvent(
                                                              fullName: _fullNameController.text,
                                                              phoneNumber: _phoneNuController.text,
                                                              email: _emailController.text,
                                                              password: _passwordController.text,
                                                              otp:"" ,
                                                              storeType:"Fabric" ,
                                                              context: context
                                                          )
                                                      );
                                                    }
                                                  }

                                                },
                                                child:  Center(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Text("Sign Up",
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
                                      SizedBox(height: screenHeight/90,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Have an account?", style: TextStyle(fontSize: screenHeight/60),),
                                          SizedBox(width: screenWidth/90,),
                                          InkWell(
                                              onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  BlocProvider(
                                                    create: (context) => LoginBloc(),
                                                    child: const SignInScreen(),
                                                  ),));
                                                // Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(),));
                                              },
                                              child: Text("Sign In Now", style: TextStyle(color: ColorsConstant.pinkColor, fontWeight: FontWeight.bold, fontSize: 13),))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight/90,),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("By creating an account or logging in, you agree to",style: TextStyle(fontSize: screenHeight/75, fontWeight: FontWeight.w600), ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text("LOVOJ's", style: TextStyle(fontSize: screenHeight/75,fontWeight: FontWeight.w600),),
                                    SizedBox(width: screenWidth/90,),
                                    InkWell(
                                        onTap: () {

                                        },
                                        child: Text("Privacy Policy", style: TextStyle(color: ColorsConstant.pinkColor, fontWeight: FontWeight.bold, fontSize: screenHeight/75),))
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ]
                ),
              ),
              SizedBox(height: screenHeight/70,),
              Row(
                children: [
                  Icon(Icons.arrow_right_outlined, color: ColorsConstant.pinkColor,size: screenHeight/28,),
                  Text("Need Help?", style: TextStyle(fontSize: screenHeight/50, fontWeight: FontWeight.w600),),
                ],
              )
            ],

          ),
        ],
      ),
    );
  }
}
