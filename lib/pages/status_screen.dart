import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mohar_version/bloc/theme/theme_bloc.dart';
import 'package:mohar_version/custom/date_picker.dart';
import 'package:mohar_version/custom/line_tile.dart';
import 'package:mohar_version/custom/pie_chart.dart';
import 'package:mohar_version/models/data_model.dart';
import 'package:zoom_widget/zoom_widget.dart';


class StatusScreen extends StatefulWidget {
  final Data? receivedData;

  const StatusScreen({Key? key, this.receivedData}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  Map<String, double> dataMap = {
    "Bio-Decradable": 20,
    "Recycleable": 50,
    "Plastic": 12,
    "Eco-Brick": 32,
  };
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02f69a),
    const Color(0xffFA4A42),
    const Color(0xffFE9539),
  ];
  
 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // extendBody: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Color.fromARGB(255, 23, 23, 23)
              : Colors.white,
          title: Text(
            "My Activity",
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding:  EdgeInsets.only(top: 10.0.h),
              child: Stack(
                children: [
                  Row(
                    children: [
                      BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              BlocProvider.of<ThemeBloc>(context)
                                  .add(ThemeChangeEvent(value: !state.isDark));
                            },
                            child: Icon(
                              Theme.of(context).brightness == Brightness.dark
                                  ? Icons.sunny
                                  : Icons.nightlight,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              size: 25.sp,
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.0.w, 8.0.h, 35.w, 8.0.h),
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          size: 25.sp,
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
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Color.fromARGB(255, 246, 243, 243),

                          //Color.fromARGB(255, 246, 243, 243)
                        ),
                      )),
                  Positioned(
                      right: 25.5.w,
                      top: 6.1.h,
                      child: Container(
                        child:  Center(
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
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.red
                                    : Colors.red.withOpacity(0.5)),
                      )),
                ],
              ),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Color.fromARGB(255, 23, 23, 23)
                  : Colors.white,
              pinned: true,
              automaticallyImplyLeading: false,
              expandedHeight: 350.h,
              collapsedHeight: 200.h,
              flexibleSpace: Stack(
                children: [
                Padding(
                  padding:  EdgeInsets.only(bottom:25.0.h),
                  child: SizedBox(
                      height: 350.h,
                      child: LineChart(LineChartData(
                          minX: 0,
                          minY: 0,
                          titlesData: LineTiles.getTitleData(context),
                          gridData: FlGridData(
                            show: true,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                  color: Colors.transparent, strokeWidth: 1);
                            },
                            drawHorizontalLine: true,
                          
                          ),
                          borderData: FlBorderData(
                              show: true,
                              border: Border.all(
                                  color: Color.fromARGB(255, 202, 221, 241),
                                  width: 1)),
                          lineBarsData: [
                            LineChartBarData(
                                spots: const [
                                  FlSpot(0, 0),
                                  FlSpot(1, 500),
                                  FlSpot(2, 450),
                                  FlSpot(3, 23),
                                  FlSpot(4, 5000),
                                  FlSpot(5, 230),
                                  FlSpot(6, 2790),
                                  FlSpot(7, 600),
                                  FlSpot(8, 8000)
                                ],
                                isCurved: true,
                                preventCurveOverShooting: true,
                                gradient: LinearGradient(colors: gradientColors),
                                barWidth: 3,
                                belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                        colors: gradientColors
                                            .map(
                                                (color) => color.withOpacity(0.3))
                                            .toList())))
                          ])),
                    ),
                ),
                    Positioned(bottom: 15.h,
                      right:20.w,child: SizedBox(height: 20.h,child: PickDate())),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(((context, index) {
                return Container(
                    height: 570.h,
                    // color: Colors.green,
                    child: Stack(
                      children: [
                        Padding(
                          padding:  EdgeInsets.all(10.0.sp),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding:
                                     EdgeInsets.only(right: 230.w, top: 5.h),
                                child: Text(
                                  "This Week",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.sp,
                                      color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(
                                    left: 15.w, top: 2.h, bottom: 5.h),
                                child: Row(
                                  children: [
                                    Text(
                                      "3456785 ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40.sp),
                                    ),
                                    Text(
                                      "total ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 0.h),
                                child: PieChartSample3(),
                              ),
                              CardRow("Plastic", const Color(0xfff8b250)),
                              CardRow("Eco-Brick", const Color(0xff845bef)),
                              CardRow(
                                  "Bio-Decradable", const Color(0xff13d38e)),
                              CardRow("Recycle", const Color(0xff0293ee))
                            ],
                          ),
                        )
                      ],
                    ));
              }), childCount: 1),
            )
          ],
        ),
      ),
    );
  }

  Card CardRow(String txt, Color color) {
    return Card(
      elevation: 0.4,
      child: Padding(
        padding:  EdgeInsets.only(
            top: 8.0.h, left: 40.0.w, bottom: 8.0.h, right: 8.0.w),
        child: Row(
          children: [
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(5.r)),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 50.0.w),
              child: Text(txt),
            )
          ],
        ),
      ),
    );
  }
}
