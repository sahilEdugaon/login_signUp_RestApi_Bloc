import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovej/Screen/homeScreen.dart';
import 'package:lovej/Screen/sign_up_screen.dart';
import 'package:lovej/Screen/verify_code.dart';
import 'package:lovej/bloc/LoginBloc/login_bloc.dart';
import 'package:lovej/bloc/LoginBloc/login_event.dart';
import 'package:lovej/bloc/LoginBloc/login_state.dart';
import 'package:lovej/utils/snack_bar.dart';

import '../bloc/SignUpBloc/signUp_bloc.dart';
import '../utils/colors_constant.dart';
import '../utils/image_constant.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // String? selectedValue;
  String? selectedValue = "Admin";
  String deviceToken = "";
  List<String> items = ["Select","Admin", "Designer"];
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true;


  @override
  void dispose() {
    // TODO: implement dispose

    LoginBloc().close();

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
                          height: screenHeight/1.48,
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
                                      SizedBox(height: screenHeight /50,),
                                      Text("Designer", style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: screenHeight/25, fontWeight: FontWeight.w600),)),
                                      Text("Welcome Back!", style: TextStyle(fontSize: screenWidth/18, fontWeight: FontWeight.w500),),
                                      SizedBox(height: screenHeight/60,),
                                      BlocBuilder<LoginBloc,LoginState>(
                                        builder: (BuildContext context, state) {
                                          if(state is LoginErrorState){
                                            return   Row(
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
                                      SizedBox(
                                        child: DropdownButtonFormField<String>(
                                          // iconEnabledColor: IconsConstant.lightPinkColor,
                                          decoration: InputDecoration(
                                            hintText: "Select",
                                            hintStyle: TextStyle(fontSize: screenHeight / 55),
                                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                            border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
                                            focusedBorder:  OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: ColorsConstant.pinkColor,width: 1.5),
                                            ),
                                          ),
                                          value: selectedValue,
                                          icon: Icon(Icons.arrow_drop_down_sharp, size: screenHeight/28,),
                                          style: const TextStyle(color: Colors.black),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedValue = newValue;
                                            });
                                          },
                                          validator: (value) {
                                            if (value == null || value == "Select") {
                                              return 'Please select a Option';
                                            }
                                            return null;
                                          },
                                          items: items.map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      SizedBox(height: screenHeight/50,),

                                      TextField(
                                        controller: _emailController,
                                        onChanged: (value){
                                          BlocProvider.of<LoginBloc>(context).add(
                                            LoginTextChangeEvent(email: _emailController.text, password: _passwordController.text)
                                          );
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                          hintText: "Enter Your Email",
                                          hintStyle: TextStyle(fontSize: screenHeight/55),
                                          suffixIcon: Icon(Icons.mail_outline_outlined, size: screenHeight/38,),
                                          focusedBorder:  OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(color: ColorsConstant.pinkColor,width: 1.5),
                                          ),

                                        ),

                                      ),

                                      SizedBox(height: screenHeight/50,),
                                      TextField(
                                        controller: _passwordController,
                                        obscureText: _isPasswordHidden,
                                        onChanged: (value){
                                          BlocProvider.of<LoginBloc>(context).add(
                                              LoginTextChangeEvent(email: _emailController.text, password: _passwordController.text)
                                          );
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                          hintText: "Enter Your Password",
                                          hintStyle: TextStyle(fontSize: screenHeight/55),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                                              size: screenHeight / 38,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _isPasswordHidden = !_isPasswordHidden;
                                              });
                                            },
                                          ),
                                          focusedBorder:  OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(color: ColorsConstant.pinkColor,width: 1.5),
                                          ),

                                        ),

                                      ),
                                      SizedBox(height: screenHeight/90,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                               // Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyCode(),));
                                              },
                                              child: Text("Forget Password?", style: TextStyle(color: ColorsConstant.pinkColor, fontWeight: FontWeight.w500, fontSize: screenHeight/70),))
                                        ],
                                      ),
                                      SizedBox(height: screenHeight/30,),
                                      BlocBuilder<LoginBloc,LoginState>(
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
                                               print('state-$state');
                                                  if(_emailController.text.isEmpty && _passwordController.text.isEmpty){
                                                    snackBar(context, 'Please Enter Email and Password', Colors.white, Colors.red);
                                                  }
                                                 else if(state is LoginValid){
                                                    BlocProvider.of<LoginBloc>(context).add(
                                                        LoginSubmitBtnEvent(
                                                            email: _emailController.text,
                                                            password: _passwordController.text,
                                                            role: selectedValue.toString().toUpperCase()=='ADMIN'?'admin':"user",
                                                            deviceToken: deviceToken,
                                                             context: context
                                                        )
                                                    );
                                                  }
                                                 else{
                                                    snackBar(context, 'Please Valid Email and Password', Colors.white, Colors.red);

                                                  }


                                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const VerifyCode()));

                                                },
                                                child:  Center(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Text("Sign In",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      (state is LoginLoadingState)
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

                                      SizedBox(height: 15,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Don't have an account?", style: TextStyle(fontSize: screenHeight/65),),
                                          SizedBox(width: screenWidth/90,),
                                          InkWell(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  BlocProvider(
                                                    create: (context) => SignUpBloc(),
                                                   child: const SignUpScreen(),
                                                ),));
                                              },
                                              child: const Padding(
                                                  padding: EdgeInsets.all(1),
                                                  child: Text("Sign Up Now", style: TextStyle(color: ColorsConstant.pinkColor,
                                                      fontWeight: FontWeight.bold, fontSize: 13),)
                                              )
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight/17,),
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


