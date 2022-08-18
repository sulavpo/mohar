import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DialougeForm{

showDialouge({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: SizedBox(
              height: 500.h,
              width: 500.w,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     Text(
                      "Terms & Conditions",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                     Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                          "1. By using the MyMobileApp.online \n website or any of the My Mobile\n App mobile apps services, you are agreeing to be bound by\n the following terms and conditions",
                          style: TextStyle(fontSize: 15.sp)),
                    ),
                     Text(
                        "2.The definition of “The Client” used in this document pertains at all times to the\n organization that is the intended party requesting apps from My Mobile App.",
                        style: TextStyle(fontSize: 15.sp)),
                     Text(
                        "3.The Client is responsible for maintaining the security of their online account and password.",
                        style: TextStyle(fontSize: 15.sp)),
                    const Text(
                        "4. By using My Mobile App, The Client asserts itself to have ownership and license,or some other clearn right, to enter the Agreement on behalf of the website submitted to My Mobile App. In the event that the right to enter the Agreement is shown to be non existent, or a competing claim of right is proven to be stronger, Appswiz reserves the right to remove the application from its systems, or alter the"),
                    Padding(
                      padding:  EdgeInsets.only(left: 130.0.w, top: 10.h),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Ok',
                            style:  TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
  

}