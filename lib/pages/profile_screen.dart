import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mohar_version/Constants/image.dart';
import 'package:mohar_version/animation/home_animation.dart';
import 'package:mohar_version/bloc/app_bloc.dart';
import 'package:mohar_version/custom/row.dart';
import 'package:mohar_version/models/data_model.dart';
import 'package:mohar_version/pages/home_page.dart';
import 'package:mohar_version/pages/login_page.dart';

class ProfileScreen extends StatefulWidget {
  final Data? receivedData;
  ProfileScreen(
      {Key? key, required AnimationController controller, this.receivedData})
      : animation = HomePageEnterAnimation(controller),
        super(key: key);
  final HomePageEnterAnimation animation;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: widget.animation.controller,
          builder: (context, child) => _buildAnimation(context, child, size),
        ),
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child, Size size) {
    return SafeArea(
      child: Stack(
        children: [
          Column(children: <Widget>[
            topBar(widget.animation.barHeight.value),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 23),
                  Opacity(
                      opacity: widget.animation.tittleOpacity.value,
                      child: placeholderBox(28, 150, Alignment.centerLeft)),
                  SizedBox(
                    height: 8,
                  ),
                  Opacity(
                      opacity: widget.animation.textOpacity.value,
                      child: placeholderBox2(
                          350, double.infinity, Alignment.centerLeft)),
                ],
              ),
            )
          ]),
          background(
            size,
            widget.animation.avatarSize.value,
          ),
          circle(
            size,
            widget.animation.avatarSize.value,
          ),
        ],
      ),
    );
  }

  Padding topBar(double height) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 50),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      ),
    );
  }

  Positioned circle(Size size, double animationValue) {
    return Positioned(
        top: 150,
        left: size.width / 2 - 150,
        child: Transform(
          alignment: Alignment.center,
          transform:
              Matrix4.diagonal3Values(animationValue, animationValue, 1.0),
          child: Container(
            height: 90,
            width: 90,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  widget.receivedData!.profile,
                  fit: BoxFit.cover,
                )),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue.shade700),
          ),
        ));
  }

  Positioned background(Size size, double animationValue) {
    return Positioned(
        top: 147,
        left: size.width / 2 - 153,
        child: Transform(
          alignment: Alignment.center,
          transform:
              Matrix4.diagonal3Values(animationValue, animationValue, 1.0),
          child: Container(
            height: 96,
            width: 95.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.white),
          ),
        ));
  }

  Align placeholderBox(double height, double width, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        child: Center(
            child: Text(
          widget.receivedData!.fullname,
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade300),
      ),
    );
  }

  Align placeholderBox2(double height, double width, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        child: ListView(
                                      children: [
                                        CustomRow().customRow(
                                            data: widget.receivedData!.fullname,
                                            label: 'Name:\t',
                                            context: context,
                                            type: 'name'),
                                        CustomRow().customRow(
                                            data: widget.receivedData!.email,
                                            label: 'Mother Name:\t',
                                            context: context,
                                            type: 'mother'),
                                        CustomRow().customRow(
                                            data: widget.receivedData!.gender,
                                            label: 'Father Name:\t',
                                            context: context,
                                            type: 'father'),
                                        CustomRow().customRow(
                                            data: widget.receivedData!.password,
                                            label: 'Password:\t',
                                            context: context,
                                            type: 'password'),
                                        CustomRow().customRow(
                                            data: widget.receivedData!.phone,
                                            label: 'Phone:\t',
                                            context: context,
                                            type: 'phone'),
                                        CustomRow().customAddress(
                                            city: widget.receivedData!.address.city,
                                            context: context,
                                            type: 'address',
                                            district:
                                                widget.receivedData!.address.district,
                                            provision:
                                                widget.receivedData!.address.provision)
                                      ],
                                    ),
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade300),
      ),
    );
  }
}
