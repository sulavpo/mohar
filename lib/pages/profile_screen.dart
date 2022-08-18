import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mohar_version/Constants/image.dart';
import 'package:mohar_version/animation/home_animation.dart';
import 'package:mohar_version/bloc/app_bloc.dart';
import 'package:mohar_version/bloc/theme/theme_bloc.dart';
import 'package:mohar_version/custom/dialouge.dart';
import 'package:mohar_version/custom/update_dialouge.dart';
import 'package:mohar_version/models/data_model.dart';
import 'package:mohar_version/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final Data? receivedData;
  const ProfileScreen({Key? key, this.receivedData}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Future<void> savedata(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("switch", value);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is MoharNotLoggedinState) {
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
        }
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
          children: [
            AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Color.fromARGB(255, 23, 23, 23)
                  : Colors.white,
              title: Text(
                "Profile",
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(top: 10.0.h),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          BlocBuilder<ThemeBloc, ThemeState>(
                            builder: (context, state) {
                              return InkWell(
                                onTap: () {
                                  BlocProvider.of<ThemeBloc>(context).add(
                                      ThemeChangeEvent(value: !state.isDark));
                                },
                                child: Icon(
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Icons.sunny
                                      : Icons.nightlight,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  size: 25,
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(15.0.w, 8.0.h, 35.w, 8.0.h),
                            child: FaIcon(
                              FontAwesomeIcons.bell,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                          right: 26.w,
                          top: 6.h,
                          child: Container(
                            height: 16.h,
                            width: 16.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black
                                  : Color.fromARGB(255, 246, 243, 243),

                              //Color.fromARGB(255, 246, 243, 243)
                            ),
                          )),
                      Positioned(
                          right: 25.5.w,
                          top: 6.1.h,
                          child: Container(
                            child: Center(
                                child: Text(
                              "1",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                            height: 15.h,
                            width: 15.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.red
                                    : Colors.red.withOpacity(0.5)),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 150.w, 0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100.h,
                    width: 100.w,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          widget.receivedData!.profile,
                          fit: BoxFit.fill,
                          width: 100.w,
                          height: 100.h,
                        )),
                    decoration: const BoxDecoration(
                        color: Colors.amber, shape: BoxShape.circle),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15.0.w, top: 3.h),
                        child: Container(
                          height: 15.h,
                          width: 65.w,
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(2.r)),
                          child: Center(
                              child: Text(
                            "Contributor",
                            style:
                                TextStyle(fontSize: 10.sp, color: Colors.white),
                          )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0.w, top: 5.h),
                        child: Text(
                          widget.receivedData!.fullname.split(' ').first,
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0.w, top: 3.h),
                        child: Text(
                          "View Profile",
                          style: TextStyle(
                              color: Color.fromRGBO(76, 175, 152, 1),
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 90.h,
                    width: 90.w,
                    child: Center(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 30.0.h),
                            child: Text(
                              "5k",
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 22.0.h),
                            child: Text(
                              "Points",
                              style: TextStyle(
                                  color: Color.fromRGBO(158, 158, 158, 1),
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  Container(
                    height: 90.h,
                    width: 90.w,
                    child: Center(
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0.h),
                            child: Image.asset(
                              AppImages.medal,
                              width: 90.w,
                              height: 90.h,
                            ),
                          ),
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 30.0.h, left: 28.w),
                                child: Text(
                                  "1k",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 22.0.h, left: 30.w),
                                child: Text(
                                  "Rank",
                                  style: TextStyle(
                                      color: Color.fromRGBO(158, 158, 158, 1),
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  Container(
                    height: 90.h,
                    width: 90.r,
                    child: Center(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 30.0.h),
                            child: Text(
                              "2k",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 22.0.h),
                            child: Text(
                              "Withdraw",
                              style: TextStyle(
                                  color: Color.fromRGBO(158, 158, 158, 1),
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10.r)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 320.h,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                child: ListView(
                  primary: false,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    ListCard(
                        title: Text("Basic info"),
                        trailing: Icon(Icons.chevron_right),
                        leading: Container(
                            height: 25.h,
                            width: 25.w,
                            decoration: BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              AppImages.info,
                              height: 50.h,
                              width: 50.w,
                            ))),
                    InkWell(
                      onTap: () {
                        ShowDialouge().showDialouge(
                            city: "",
                            district: "",
                            provision: "",
                            text: "Change Password",
                            context: context,
                            data: widget.receivedData!.password,
                            type: "password",
                            text1: "",
                            text2: "",
                            text3: "");
                      },
                      child: ListCard(
                          title: Text("Change Password"),
                          trailing: Icon(Icons.chevron_right),
                          leading: Container(
                              height: 25.h,
                              width: 25.w,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: SvgPicture.asset(AppImages.password,
                                  height: 50.h, width: 50.w))),
                    ),
                    ListCard(
                        title: Theme.of(context).brightness == Brightness.dark
                            ? Text("Light Theme")
                            : Text("Dark Theme"),
                        trailing: BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, state) {
                            return Switch(
                                value: state.isDark,
                                onChanged: (value) {
                                  print(value);
                                  BlocProvider.of<ThemeBloc>(context)
                                      .add(ThemeChangeEvent(value: value));
                                  savedata(value);
                                });
                          },
                        ),
                        leading: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Theme.of(context).brightness == Brightness.dark
                              ? SvgPicture.asset(AppImages.light,
                                  height: 50.h, width: 50.w)
                              : SvgPicture.asset(AppImages.dark,
                                  height: 50.h, width: 50.w),

                          // child: SvgPicture.asset(AppImages.dark,
                          //     height: 50, width: 50)
                        )),
                    ListCard(
                        title: Text("FAQs"),
                        trailing: Icon(Icons.chevron_right),
                        leading: Container(
                            height: 25.h,
                            width: 25.w,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: SvgPicture.asset(AppImages.fq,
                                height: 50.h, width: 50.w))),
                    ListCard(
                        title: Text("Refer and Earn"),
                        trailing: Icon(Icons.chevron_right),
                        leading: Container(
                            height: 25.h,
                            width: 25.w,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: SvgPicture.asset(AppImages.share,
                                height: 50, width: 50))),
                    InkWell(
                      onTap: () {
                        // setState(() {
                        BlocProvider.of<AppBloc>(context).add(LogoutEvent());
                        // });
                      },
                      child: ListCard(
                          title: Text("Logout"),
                          leading: Container(
                              height: 25.h,
                              width: 25.w,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: SvgPicture.asset(AppImages.logout,
                                  height: 50.h, width: 50.w))),
                    ),
                  ],
                ),
              ),
            )
          ],
        ))),
      ),
    );
  }

  Card ListCard({required leading, required title, trailing}) => Card(
      elevation: 0.8,
      // color: Color.fromARGB(246, 254, 253, 253),
      child: ListTile(
        leading: leading,
        title: title,
        trailing: trailing,
      ));
}
