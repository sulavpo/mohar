import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohar_version/Constants/image.dart';
import 'package:mohar_version/bloc/app_bloc.dart';
import 'package:mohar_version/custom/dialouge.dart';
import 'package:mohar_version/custom/toast.dart';
import 'package:mohar_version/models/address_model.dart';
import 'package:mohar_version/models/data_model.dart';
import 'package:mohar_version/pages/home_page.dart';
import 'package:mohar_version/pages/next_page.dart';

class SelfieClick extends StatefulWidget {
  final NextArgument ar;
  const SelfieClick({Key? key, required this.ar}) : super(key: key);
  static const routeName = "/Next_page";

  @override
  State<SelfieClick> createState() => _SelfieClickState();
}

class ImageModel {
  bool isFront;
  String imageUrl;
  ImageModel({required this.imageUrl, required this.isFront});
}

class _SelfieClickState extends State<SelfieClick> {
  Future<List<ImageModel>> uploadFile() async {
    final path1 = '/profile/${pickedXfile3!.name}';

    List<ImageModel> images = [];

    final ref1 = FirebaseStorage.instance.ref().child(path1);
    await ref1.putFile(pickedImage3!);
    image3Url = await ref1.getDownloadURL();

    images.add(ImageModel(imageUrl: image3Url!, isFront: true));
    return images;
    // final results = await File(pickedImage1!.path);
  }

  bool loading = false;

  String? image3Url;
  XFile? pickedXfile3;

  File? pickedImage3;
  bool isChecked = false;
  static Future<XFile?> _pickImage(ImageSource imageSource) async {
    return await ImagePicker().pickImage(source: imageSource);
  }

  bool agree = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser(Data data, String uid) async {
    data.uid = uid;
    // await users.doc(uid).set({'uid': uid});
    return users
        .doc(uid)
        .set(
          data.toMap(),
        )
        .then((value) async {
      List<ImageModel> images = await uploadFile();

      print("User Added");
      // Navigator.pushNamed(context, LandingScreen.routeName);
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addReal(Data data, String uid) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
    return await ref.set(data.toMap()).then((value) {
      print("User also Added to RealTime Database");
      BlocProvider.of<AppBloc>(context).add(RegisterEvent());
    }).catchError((error) => print("Failed to add user: $error"));
  }

  void _doSomething(Data data) async {
    if (widget.ar.test!) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: widget.ar.email!, password: widget.ar.password!)
            .then((value) async {
          String uid = _auth.currentUser!.uid;
          addUser(data, uid);
          addReal(data, uid);
        });
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.code)));
      }
    } else {
      try {
        String uid = _auth.currentUser!.uid;
        addUser(data, uid);
        addReal(data, uid);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.code)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is MoharLoggedinState) {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding:
                       EdgeInsets.only(left: 20.0.w, right: 20.w, top: 25.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          )),
                      const Text(
                        '3/3',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.only(right: 45.w, top: 10.h),
                  child: Text('Verify Your Identity',
                      style:
                          TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold)),
                ),
                SvgPicture.asset(
                  AppImages.id,
                  width: 200.w,
                  height: 200.h,
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 80.w, right: 80.h),
                  child: Container(
                    child:  Text(
                        '\tA Picture of the document and your selfie will be checked',
                        style: TextStyle(fontSize: 14.sp),
                        textAlign: TextAlign.left),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 20.0.h, left: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: agree,
                          onChanged: (value) {
                            setState(() {
                              agree = value ?? false;
                            });
                          }),
                      RichText(
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.end,
                          textDirection: TextDirection.rtl,
                          softWrap: true,
                          maxLines: 2,
                          textScaleFactor: 1,
                          text: TextSpan(
                              text:
                                  "By agree and confirm to have read and accepted \nthe ",
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12.sp),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "T&Cs and data policy",
                                    style:  TextStyle(
                                        color: Colors.blue, fontSize: 12.sp),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        DialougeForm()
                                            .showDialouge(context: context);
                                      })
                              ])),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.fromLTRB(40.w, 10.h, 40.w, 0.h),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                               EdgeInsets.all(10.sp)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r)),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(76, 175, 80, 1))),
                      onPressed: (() {
                        setState(() {
                          _showDialog();
                        });
                      }),
                      child:  Center(
                          child: Text(
                        'Take A selfie',
                        style: TextStyle(fontSize: 15.sp),
                      ))),
                ),
                Padding(
                  padding:  EdgeInsets.fromLTRB(40.w, 10.h, 40.w, 0.h),
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
                        List<String> fullAddress =
                            widget.ar.address!.split(',');
                        // String uid = _auth.currentUser!.uid;

                        FullAddress addressModel = FullAddress(
                            city: fullAddress[0],
                            district: fullAddress[1],
                            provision: fullAddress[2]);
                        if (pickedImage3 == null) {
                          return Toasts.showToast(
                              "Please Take a Selfie", Colors.red);
                        } else {
                          if (agree) {
                            setState(() {
                              loading = true;
                            });
                            List<ImageModel> images = await uploadFile();
                            setState(() {
                              loading = false;
                            });
                            _doSomething(Data(
                                widget.ar.fullname!,
                                addressModel,
                                widget.ar.email!,
                                widget.ar.phone!,
                                widget.ar.gender!,
                                widget.ar.dctype!,
                                widget.ar.front!,
                                widget.ar.back!,
                                widget.ar.password!,
                                images[0].imageUrl,
                                null,
                                0,
                                0));
                          } else {
                            Toasts.showToast(
                                "Select I agree to continue", Colors.blue);
                          }
                        }
                      }),
                      child:  Center(
                          child: Text(
                        'Finish',
                        style: TextStyle(fontSize: 15.sp),
                      ))),
                ),
                Padding(
                  padding:  EdgeInsets.all(28.0.sp),
                  child: Container(
                    height: 70.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                        image: (pickedImage3 != null)
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(pickedImage3!))
                            : null,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.r)),
                  ),
                ),
              ],
            ),
            loading
                ? Container(
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.4),
                    child: Center(
                        child: Container(
                            padding:  EdgeInsets.all(40.sp),
                            color: Colors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                CircularProgressIndicator(),
                                Text("Please Wait......")
                              ],
                            ))),
                  )
                : const SizedBox()
          ],
        )),
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SizedBox(
                child: Column(children: [
                   Text(
                    'Smile You are on camera',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: 20.0.h),
                    child: Container(
                      height: 150.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          image: (pickedImage3 != null)
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(pickedImage3!))
                              : null,
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r)),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.fromLTRB(0.w, 20.h, 0.w, 0.h),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                 EdgeInsets.only(left: 60.w, right: 60.w)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r)),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(2550, 870, 1510, 2030))),
                        onPressed: (() async {
                          pickedXfile3 = await _pickImage(ImageSource.camera);
                          if (pickedXfile3 != null) {
                            setState(() {
                              pickedImage3 = File(pickedXfile3!.path);
                            });
                          }
                        }),
                        child:  Text(
                          'Touch to Click',
                          style: TextStyle(fontSize: 15.sp),
                        )),
                  ),
                  Padding(
                    padding:  EdgeInsets.fromLTRB(0.w, 5.h, 0.w, 0.h),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                 EdgeInsets.only(left: 85.w, right: 85.w)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r)),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(76, 175, 80, 1))),
                        onPressed: (() async {
                          pickedXfile3 = await _pickImage(ImageSource.camera);
                          if (pickedXfile3 != null) {
                            setState(() {
                              pickedImage3 = File(pickedXfile3!.path);
                            });
                          }
                        }),
                        child:  Text(
                          'Retake',
                          style: TextStyle(fontSize: 15.sp),
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ]),
                height: 350.h,
                width: 50.w,
              ),
            );
          });
        });
  }
}
