import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mohar_version/Constants/image.dart';
import 'package:mohar_version/custom/bottomsheet.dart';
import 'package:mohar_version/custom/card.dart';
import 'package:mohar_version/models/data_model.dart';
import 'package:mohar_version/models/logo_model.dart';

class LandingScreen extends StatefulWidget {
  final Data? receivedData;

  const LandingScreen({Key? key, this.receivedData}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      // value:0.8,
      vsync: this,
      upperBound: 0.334,
      duration: Duration(milliseconds: 3500))
    ..forward();

  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

  int _currentindex = 0;
  int _newindex = 0;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            child: SafeArea(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 10),
                      child: Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                widget.receivedData!.profile,
                                fit: BoxFit.cover,
                              )),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red.withOpacity(0.3),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0, right: 15),
                      child: Text(
                        "Hi ${widget.receivedData!.fullname.split(' ').first}!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 120,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 60,
                            top: 10,
                            child: const Center(
                                child: FaIcon(FontAwesomeIcons.bell)),
                          ),
                          Positioned(
                              right: 30,
                              bottom: 55,
                              child: Container(
                                height: 16,
                                width: 16,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 246, 243, 243)),
                              )),
                          Positioned(
                              right: 29,
                              bottom: 56,
                              child: Container(
                                child: const Center(
                                    child: Text(
                                  "1",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )),
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.withOpacity(0.3)),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 170,
                  width: 320,
                  child: Stack(
                    children: [
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (_, child) {
                          return Transform.rotate(
                            angle: (_animation.value),
                            child: Container(
                              height: 150,
                              width: 320,
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          );
                        },
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Your Balance",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "245",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text("Total:11,456",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      // color: Colors.amber,
                                      width: 100,
                                      height: 100,
                                      child: TweenAnimationBuilder<double>(
                                        tween: Tween<double>(
                                            begin: 0, end: (245 / 2000)),
                                        duration: const Duration(seconds: 1),
                                        builder: (context, value, _) =>
                                            CircularProgressIndicator.adaptive(
                                          value: value,
                                          strokeWidth: 10,
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "${(245 / 2000) * 100}%",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        height: 150,
                        width: 320,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LogoPart(
                                title: withDrawList[index].title,
                                iconName: withDrawList[index].iconName,
                                color: _newindex == index
                                    ? Color.fromARGB(255, 216, 217, 219)
                                    : Colors.white,
                                onTap: () {
                                  setState(() {
                                    _newindex = index;
                                  });
                                }),
                          );
                        }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 0),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, top: 0),
                      child: Text(
                        "see all",
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: SizedBox(
                    height: 150,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: logoPartList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LogoPart(
                                title: logoPartList[index].title,
                                iconName: logoPartList[index].iconName,
                                color: _currentindex == index
                                    ? Color.fromARGB(255, 216, 217, 219)
                                    : Colors.white,
                                onTap: () {
                                  setState(() {
                                    _currentindex = index;
                                  });
                                }),
                          );
                        }),
                  ),
                )
              ],
            )),
            height: 1050,
            padding: const EdgeInsets.fromLTRB(3, 3, 3, 70),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 246, 243, 243),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(3, 500, 3, 0),
          child: GestureDetector(
            onTap: () {
              BottomSheets().bottomsheets(context);
            },
            child: Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTapUp: (details) {
                      BottomSheets().bottomsheets(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 150.0, right: 150, top: 12),
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 216, 217, 219),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 150.0, top: 30, bottom: 5),
                    child: Text(
                      "Highest Contributor",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Container(
                    height: 110,
                    child: CardForm().cardField(
                        coin: "5000",
                        rank: "1st Rank",
                        name: "Suraj Pandey",
                        avatar: AppImages.avatar1),
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
            ),
          ),
        )
      ]),
    );
  }
}
