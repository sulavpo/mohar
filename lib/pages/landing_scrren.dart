import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'dart:math' as math;
// import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mohar_version/custom/bottomsheet.dart';
import 'package:mohar_version/custom/card.dart';
import 'package:mohar_version/models/data_model.dart';
import 'package:mohar_version/models/logo_model.dart';

class LandingScreen extends StatefulWidget {
  final Data? receivedData;
  final Function(int) callback;

  const LandingScreen({Key? key, this.receivedData, required this.callback})
      : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      // value:0.8,
      vsync: this,
      upperBound: 0.334,
      duration: const Duration(milliseconds: 3500))
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
          padding:  EdgeInsets.all(3.0.sp),
          child: Container(
            child: SafeArea(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(bottom: 8.0.h, left: 10.w),
                      child: InkWell(
                        onTap: () {
                          widget.callback(3);
                        },
                        child: Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.network(
                                  widget.receivedData!.profile,
                                  fit: BoxFit.cover,
                                )),
                            height: 40.h,
                            width: 40.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Colors.red.withOpacity(0.3),
                            )),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(bottom: 8.0.h, right: 15.w),
                      child: Text(
                        "Hi ${widget.receivedData!.fullname.split(' ').first}!",
                        style:  TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                      width: 120.w,
                      child: Stack(
                        children: [
                           Positioned(
                            left: 60.w,
                            top: 10.h,
                            child: const Center(child: FaIcon(FontAwesomeIcons.bell)),
                          ),
                          Positioned(
                              right: 30.w,
                              bottom: 55.h,
                              child: Container(
                                height: 16.h,
                                width: 16.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.black
                                      : const Color.fromARGB(255, 246, 243, 243),
                                  //Color.fromARGB(255, 246, 243, 243)
                                ),
                              )),
                          Positioned(
                              right: 29.w,
                              bottom: 56.h,
                              child: Container(
                                child:  Center(
                                    child: Text(
                                  "1",
                                  style: TextStyle(
                                      fontSize: 10.sp,
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
                    )
                  ],
                ),
                SizedBox(
                  height: 170.h,
                  width: 320.w,
                  child: Stack(
                    children: [
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (_, child) {
                          return Transform.rotate(
                            angle: (_animation.value),
                            child: Container(
                              height: 150.h,
                              width: 320.w,
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(20.r)),
                            ),
                          );
                        },
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:  EdgeInsets.only(left: 20.0.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Your Balance",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0.h),
                                      child: Text(
                                        "${widget.receivedData!.balance}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0.h),
                                      child: Text(
                                          "Total:${widget.receivedData!.points}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.sp,
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
                                    child: SizedBox(
                                      // color: Colors.amber,
                                      width: 100.w,
                                      height: 100.h,
                                      child: TweenAnimationBuilder<double>(
                                        tween: Tween<double>(
                                            begin: 0,
                                            end: (widget.receivedData!.balance /
                                                2000)),
                                        duration: const Duration(seconds: 1),
                                        builder: (context, value, _) =>
                                            CircularProgressIndicator.adaptive(
                                          value: value,
                                          strokeWidth: 15,
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "${((widget.receivedData!.balance / 2000) * 100).toStringAsPrecision(3)}%",
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color.fromRGBO(71, 71, 71, 1)
                                    : Colors.black,
                            borderRadius: BorderRadius.circular(20.r)),
                        height: 150,
                        width: 320,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: SizedBox(
                    height: 100.h,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:  EdgeInsets.all(8.0.sp),
                            child: LogoPart(
                                title: withDrawList[index].title,
                                iconName: withDrawList[index].iconName,
                                color: _newindex == index
                                    ? const Color.fromARGB(255, 216, 217, 219)
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
                      padding: EdgeInsets.only(left: 15.0.w),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0.w),
                      child: Text(
                        "see all",
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: SizedBox(
                    height: 150.h,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: logoPartList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:  EdgeInsets.all(8.0.sp),
                            child: LogoPart(
                                title: logoPartList[index].title,
                                iconName: logoPartList[index].iconName,
                                color: _currentindex == index
                                    ? const Color.fromARGB(255, 216, 217, 219)
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
            height: 1050.h,
            padding: EdgeInsets.fromLTRB(3.w, 3.h, 3.w, 70.h),
            decoration:  BoxDecoration(
                // color: Color.fromARGB(255, 246, 243, 243),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.r),
                    topRight: Radius.circular(35.r))),
          ),
        ),
        StreamBuilder(
                      stream: FirebaseDatabase.instance.ref('users').onValue,
                      builder:
                          ((context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: Text(''));
                        } else if (snapshot.connectionState ==
                                ConnectionState.active ||
                            snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            Map data = snapshot.data!.snapshot.value as Map;
                            List<Data> userDataList = [];
                            int i = 1;
                            data.forEach((key, value) {
                              userDataList.add(Data.fromJson(value));
                              i++;
                            });
                            userDataList
                                .sort(((a, b) => b.points.compareTo(a.points)));

                            return Padding(
          padding:  EdgeInsets.fromLTRB(3.w, 500.h, 3.w, 0.h),
          child: GestureDetector(
            onTap: () {
              BottomSheets().bottomsheets(context,userDataList);
            },
            child: Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTapUp: (details) {
                      BottomSheets().bottomsheets(context,userDataList);
                    },
                    child: Padding(
                      padding:  EdgeInsets.only(
                          left: 150.0.w, right: 150.w, top: 12.h),
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 216, 217, 219),
                            borderRadius: BorderRadius.circular(20.r)),
                      ),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(right: 150.0.w, top: 30.h, bottom: 5.h),
                    child: const Text(
                      "Highest Contributor",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  CardForm().cardField(
                                coin: userDataList[0].points,
                                rank: "1",
                                name: userDataList[0].fullname,
                                avatar: userDataList[0].profile),
                ],
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color.fromARGB(255, 83, 82, 82)
                      : const Color.fromARGB(255, 241, 240, 240),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.r),
                      topRight: Radius.circular(35.r))),
            ),
          ),
        );
                            //     }));
                          }
                        }
                        return const Center(
                            child: Text('Kina bigriyo malai ni thaha chaina'));
                      })),
        
      ]),
    );
  }
}

