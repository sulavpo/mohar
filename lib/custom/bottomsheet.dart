import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mohar_version/custom/card.dart';
import 'package:mohar_version/models/data_model.dart';


class BottomSheets {
  
  void bottomsheets(context, List<Data> userDataList) {
    showModalBottomSheet(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Padding(
              padding:  EdgeInsets.fromLTRB(3.0.w, 0.h, 3.0.w, 0.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(
                              left: 150.0.w, right: 150.w, top: 5.h),
                          child: Container(
                            height: 6.h,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 216, 217, 219),
                                borderRadius: BorderRadius.circular(20.r)),
                          ),
                        ),
                         Padding(
                          padding: EdgeInsets.only(right: 150.0.w, top: 30.h),
                          child: Text(
                            "Highest Contributor",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17.sp),
                          ),
                        ),
                        Container(
                            margin:  EdgeInsets.all(8.0.sp),
                            height: 500.h,
                            child: AnimationLimiter(
                  
                              child: ListView.builder(
                                  itemCount: userDataList.length,
                                  itemBuilder: (context, index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: const Duration(milliseconds: 475),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child:FadeInAnimation(
                                          child: CardForm().cardField(
                                              coin: userDataList[index].points,
                                              rank: "${index + 1}",
                                              name: userDataList[index].fullname,
                                              avatar: userDataList[index].profile),
                                        ),
                                      ),
                                    );
                                  })
                  ,
                            )),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color.fromARGB(255, 83, 82, 82)
                          : const Color.fromARGB(255, 241, 240, 240),
                      borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r))),
                ),
              ),
            ));
  }
}
