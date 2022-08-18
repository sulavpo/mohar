import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohar_version/Constants/image.dart';

class CardForm {
  Widget cardField(
      {required double coin,
      required String rank,
      required String name,
      required String avatar}) {
    return Card(
      // padding: const EdgeInsets.all(8.0),
      elevation: 2.5,
      margin:  EdgeInsets.all(8.sp),
      child: Padding(
        padding:  EdgeInsets.all(18.0.sp),
        child: Row(
          children: [
            CircleAvatar(
              foregroundImage: Image.network(avatar).image,
              radius: 18.r,
            ),
             SizedBox(
              width: 50.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    name,
                    style:  TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15.sp),
                  ),
                   SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppImages.coin,
                        width: 20.w,
                        height: 20.h,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 8.0.w),
                        child: Text(coin.toString()),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                SvgPicture.asset(AppImages.gold_medal,width: 70.w,height: 70.h,),
                Positioned(
                  bottom: 35.h,
                  left: 29.w,
                  child: Text(
                      rank,
                      style:  TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),
                    ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
