import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextForm {
  Widget formField(
      {required String label,
      required Icon icon,
      required TextEditingController type}) {
    return Padding(
      padding:  EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
      child: TextFormField(
        controller: type,
        validator: (input) {
          if (input == "" || input == null) {
            return '$label cannot be empty';
          }
          return null;
        },
        textCapitalization: TextCapitalization.words,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r),borderSide: const BorderSide(color: Colors.grey,width: 1)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r),borderSide: const BorderSide(color: Colors.grey)),
          hintText: label,

          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide( color: Colors.blue),
              borderRadius: BorderRadius.circular(
                10.r,
              )),
          prefixIcon: icon,
        ),
      ),
    );
  }

  Widget passwordField(
      {required String label,
      required Icon icon,
      required TextEditingController type,
      required bool obscure,
      Widget? password}) {
    return Padding(
      padding:  EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
      child: TextFormField(
        obscureText: obscure,
        controller: type,
        validator: (input) {
          if (input == "" || input == null) {
            return '$label cannot be empty';
          }
          return null;
        },
        textCapitalization: TextCapitalization.words,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.grey)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10.r)),
            labelText: label,
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.circular(
                  10.r,
                )),
            prefixIcon: icon,
            suffixIcon: password),
      ),
    );
  }
}
