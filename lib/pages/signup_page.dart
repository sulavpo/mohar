import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohar_version/Constants/image.dart';
import 'package:mohar_version/bloc/app_bloc.dart';
import 'package:mohar_version/custom/form.dart';
import 'package:mohar_version/models/next_page_view.dart';
import 'package:mohar_version/pages/login_page.dart';
import 'package:mohar_version/pages/next_page.dart';

class SignupArguments {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? address;

  SignupArguments(
      {this.id,
      this.name,
      this.address,
      this.email,
      this.password,
      this.phone});
}

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  static const routeName = "/Signup-Page";

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _frmkey = GlobalKey<FormState>();
  final fullname = TextEditingController();
  final emailText = TextEditingController();
  final passwordText = TextEditingController();
  final confirmPassword = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();
  bool hidePassword = true;
  bool hidePassword1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is MoharLoggedinState) {
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Form(
              key: _frmkey,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            )),
                        const Text(
                          '1/3',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                    child: SvgPicture.asset(AppImages.register,
                        height: 120, width: 120),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("Register to Get Cash",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, right: 18, top: 15),
                    child: TextForm().formField(
                        label: "Email",
                        icon: const Icon(Icons.alternate_email_sharp,
                            color: Colors.black),
                        type: emailText),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, right: 18, top: 15),
                    child: TextForm().formField(
                        label: "Fullname",
                        icon: const Icon(
                          Icons.account_circle,
                          color: Colors.black,
                        ),
                        type: fullname),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, right: 18, top: 15),
                    child: TextForm().formField(
                        label: "Phone Number",
                        icon: const Icon(Icons.phone, color: Colors.black),
                        type: phone),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, right: 18, top: 15),
                    child: TextForm().formField(
                        label: "Address",
                        icon:
                            const Icon(Icons.home_filled, color: Colors.black),
                        type: address),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, right: 18, top: 15),
                    child: TextForm().passwordField(
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
                        label: "Password",
                        icon: const Icon(Icons.key, color: Colors.black),
                        type: passwordText),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, right: 18, top: 15),
                    child: TextForm().passwordField(
                        obscure: hidePassword1,
                        password: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword1 = !hidePassword1;
                              });
                            },
                            icon: Icon(hidePassword1
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        label: "Confirm Password",
                        icon: const Icon(Icons.key, color: Colors.black),
                        type: confirmPassword),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 87, 151, 203))),
                        onPressed: (() async {
                          if (_frmkey.currentState!.validate()) {
                            Navigator.pushNamed(context, NextPage.routeName,
                                arguments: NextPageViewModel(
                                    signupType: SignupType.normal,
                                    signupArguments: SignupArguments(
                                        email: emailText.text,
                                        name: fullname.text,
                                        address: address.text,
                                        phone: phone.text,
                                        password: passwordText.text)));
                          }
                        }),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 110),
                          child: Row(
                            children: const [
                              Text(
                                'Next',
                                style: TextStyle(fontSize: 15),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 15,
                              )
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 90.0, top: 5, bottom: 5),
                    child: Row(
                      children: [
                        const Text(
                          'Joined us before?',
                          style: TextStyle(fontSize: 15),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.pushNamed(context, LoginPage.routeName);
                            });
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
      )),
    );
  }
}
