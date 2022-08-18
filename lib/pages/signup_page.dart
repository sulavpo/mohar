import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      // backgroundColor: Colors.white,
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
                         EdgeInsets.only(left: 20.w, right: 20.w, top: 25.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            child:  Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                            )),
                         Text(
                          '1/3',
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.fromLTRB(10.w, 30.h, 0.w, 0.h),
                    child: SvgPicture.asset(AppImages.register,
                        height: 120.h, width: 120.w),
                  ),
                   Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Text("Register to Get Cash",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding:
                         EdgeInsets.only(left: 18.w, right: 18.w, top: 15.h),
                    child: TextForm().formField(
                        label: "Email",
                        icon:  Icon(Icons.alternate_email_sharp,
                            color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,),
                        type: emailText),
                  ),
                  Padding(
                    padding:
                         EdgeInsets.only(left: 18.w, right: 18.w, top: 15.h),
                    child: TextForm().formField(
                        label: "Fullname",
                        icon:  Icon(
                          Icons.account_circle,
                          color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                        ),
                        type: fullname),
                  ),
                  Padding(
                    padding:
                         EdgeInsets.only(left: 18.w, right: 18.w, top: 15.h),
                    child: TextForm().formField(
                        label: "Phone Number",
                        icon:  Icon(Icons.phone, color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,),
                        type: phone),
                  ),
                  Padding(
                    padding:
                         EdgeInsets.only(left: 18.w, right: 18.w, top: 15.h),
                    child: TextForm().formField(
                        label: "Address",
                        icon:
                           Icon(Icons.home_filled, color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,),
                        type: address),
                  ),
                  Padding(
                    padding:
                         EdgeInsets.only(left: 18.w, right: 18.w, top: 15.h),
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
                        icon:  Icon(Icons.key, color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,),
                        type: passwordText),
                  ),
                  Padding(
                    padding:
                         EdgeInsets.only(left: 18.w, right: 18.w, top: 15.h),
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
                        icon: Icon(Icons.key, color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,),
                        type: confirmPassword),
                  ),
                  Padding(
                    padding:  EdgeInsets.fromLTRB(40.w, 20.h, 40.w, 0.h),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                 EdgeInsets.all(10.sp)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r)),
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
                          padding:  EdgeInsets.only(left: 110.w),
                          child: Row(
                            children:  [
                              Text(
                                'Next',
                                style: TextStyle(fontSize: 15.sp),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 15.sp,
                              )
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding:
                         EdgeInsets.only(left: 90.0.w, top: 5.h, bottom: 5.h),
                    child: Row(
                      children: [
                         Text(
                          'Joined us before?',
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.pushNamed(context, LoginPage.routeName);
                            });
                          },
                          child:  Text(
                            'Login',
                            style: TextStyle(color: Colors.blue, fontSize: 15.sp),
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
