// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:mohar_version/Constants/image.dart';
import 'package:mohar_version/bloc/app_bloc.dart';
import 'package:mohar_version/custom/form.dart';
import 'package:mohar_version/custom/toast.dart';
import 'package:mohar_version/pages/home_page.dart';
import 'package:mohar_version/pages/landing_scrren.dart';
// import 'package:mohar_version/custom/toast.dart';
// import 'package:mohar_version/pages/google_signin.dart';
// import 'package:mohar_version/pages/home_page.dart';
import 'package:mohar_version/pages/signup_page.dart';

class ScreenArguments {
  final String? id;
  final String? email;
  final String? displayName;

  ScreenArguments(this.id, this.email, this.displayName);
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = "/login-screen";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  bool hidePassword = true;
  final emailText = TextEditingController();
  final passwordText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            if (state is MoharLoggedinFailedState) {
              Toasts.showToast("Invalid Email/Password", Colors.red);
              // }
            } else if (state is MoharLoggedinState) {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            }
          },
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0.w, 25.h, 150.w, 0.h),
                  child: Text("Welcome Back!",
                      style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold)),
                ),
                SvgPicture.asset(
                  Theme.of(context).brightness == Brightness.light
                      ? AppImages.rupee
                      : AppImages.rupee_dark,
                  height: 170.h,
                  width: 170.w,
                ),
                Text(
                  'With Foher Get Moher',
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                  child: TextForm().formField(
                      label: "Email",
                      icon: Icon(
                        Icons.alternate_email_sharp,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      type: emailText),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                  child: TextForm().passwordField(
                    label: "Password",
                    icon: Icon(
                      Icons.password,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                    type: passwordText,
                    obscure: hidePassword,
                    password: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 10.0.h, bottom: 10.h, left: 200.w),
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40.w, 0.h, 40.w, 0.h),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(10.sp)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r)),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 87, 151, 203))),
                      onPressed: (() {
                        if (_formkey.currentState!.validate()) {
                          BlocProvider.of<AppBloc>(context).add(LoginEvent(
                              context,
                              email: emailText.text,
                              password: passwordText.text));
                        }
                      }),
                      child: Center(
                          child: Text(
                        'Login',
                        style: TextStyle(fontSize: 15.sp),
                      ))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0.h),
                  child: Text(
                    'or',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0.h),
                  child: Text('Login with', style: TextStyle(fontSize: 12.sp)),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 30.w, right: 30.w, bottom: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        AppImages.fb,
                        height: 30.h,
                        width: 30.w,
                      ),
                      InkWell(
                        onTap: () async {
                          BlocProvider.of<AppBloc>(context)
                              .add(GoogleEvent(context));
                        },
                        child: SvgPicture.asset(
                          AppImages.googl,
                          height: 30.h,
                          width: 30.w,
                        ),
                      ),
                      SvgPicture.asset(
                        AppImages.insta,
                        height: 30.h,
                        width: 30.w,
                      ),
                      SvgPicture.asset(
                        AppImages.twr,
                        height: 30.h,
                        width: 30.w,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40.w, 10.h, 40.w, 0.w),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(10.sp)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r)),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green[500])),
                      onPressed: (() {
                        setState(() {
                          Navigator.pushNamed(context, SignupPage.routeName,
                              arguments: ScreenArguments("", "", ""));
                        });
                      }),
                      child: Center(
                          child: Text(
                        'Create a Account',
                        style: TextStyle(fontSize: 15.sp),
                      ))),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
