import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mohar_version/Constants/image.dart';
import 'package:mohar_version/bloc/app_bloc.dart';
import 'package:mohar_version/custom/form.dart';
import 'package:mohar_version/custom/toast.dart';
import 'package:mohar_version/pages/google_signin.dart';
import 'package:mohar_version/pages/home_page.dart';
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
        backgroundColor: Colors.white,
        body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 25, 150, 0),
                child: Text("Welcome Back!",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              SvgPicture.asset(
                AppImages.rupee,
                height: 170,
                width: 170,
              ),
              const Text(
                'With Foher Get Moher',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextForm().formField(
                    label: "Email",
                    icon: const Icon(
                      Icons.alternate_email_sharp,
                      color: Colors.black,
                    ),
                    type: emailText),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextForm().passwordField(
                  label: "Password",
                  icon: const Icon(
                    Icons.password,
                    color: Colors.black,
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
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10, left: 200),
                child: Text(
                  'Forget Password?',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(10)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 87, 151, 203))),
                    onPressed: (() {
                      if (_formkey.currentState!.validate()) {}
                    }),
                    child: const Center(
                        child: Text(
                      'Login',
                      style: TextStyle(fontSize: 15),
                    ))),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  'or',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text('Login with', style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      AppImages.fb,
                      height: 30,
                      width: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        BlocProvider.of<AppBloc>(context)..add(GoogleEvent(context));
                      },
                      child: SvgPicture.asset(
                        AppImages.googl,
                        height: 30,
                        width: 30,
                      ),
                    ),
                    SvgPicture.asset(
                      AppImages.insta,
                      height: 30,
                      width: 30,
                    ),
                    SvgPicture.asset(
                      AppImages.twr,
                      height: 30,
                      width: 30,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(10)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green[500])),
                    onPressed: (() {
                      setState(() {
                        Navigator.pushNamed(context, SignupPage.routeName,
                            arguments: ScreenArguments("", "", ""));
                      });
                    }),
                    child: const Center(
                        child: Text(
                      'Create a Account',
                      style: TextStyle(fontSize: 15),
                    ))),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
