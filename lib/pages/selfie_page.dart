import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  FirebaseAuth _auth = FirebaseAuth.instance;

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
      BlocProvider.of<AppBloc>(context)..add(RegisterEvent());
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
            .showSnackBar(SnackBar(content: Text("${e.code}")));
      }
    } else {
      try {
        String uid = _auth.currentUser!.uid;
        addUser(data, uid);
        addReal(data, uid);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${e.code}")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is MoharLoggedinState) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                      const Text(
                        '3/3',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 45, top: 10),
                  child: Text('Verify Your Identity',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                SvgPicture.asset(
                  AppImages.id,
                  width: 200,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80, right: 80),
                  child: Container(
                    child: const Text(
                        '\tA Picture of the document and your selfie will be checked',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.left),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20),
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
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "T&Cs and data policy",
                                    style: const TextStyle(
                                        color: Colors.blue, fontSize: 12),
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
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(10)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(76, 175, 80, 1))),
                      onPressed: (() {
                        setState(() {
                          _showDialog();
                        });
                      }),
                      child: const Center(
                          child: Text(
                        'Take A selfie',
                        style: TextStyle(fontSize: 15),
                      ))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(10)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
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
                                null));
                          } else {
                            Toasts.showToast(
                                "Select I agree to continue", Colors.blue);
                          }
                        }
                      }),
                      child: const Center(
                          child: Text(
                        'Finish',
                        style: TextStyle(fontSize: 15),
                      ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        image: (pickedImage3 != null)
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    FileImage(pickedImage3!) as ImageProvider)
                            : null,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20)),
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
                            padding: const EdgeInsets.all(40),
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
              backgroundColor: Colors.white,
              content: SizedBox(
                child: Column(children: [
                  const Text(
                    'Smile You are on camera',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          image: (pickedImage3 != null)
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      FileImage(pickedImage3!) as ImageProvider)
                              : null,
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.only(left: 60, right: 60)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 87, 151, 203))),
                        onPressed: (() async {
                          pickedXfile3 = await _pickImage(ImageSource.camera);
                          if (pickedXfile3 != null) {
                            setState(() {
                              pickedImage3 = File(pickedXfile3!.path);
                            });
                          }
                        }),
                        child: const Text(
                          'Touch to Click',
                          style: TextStyle(fontSize: 15),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.only(left: 85, right: 85)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
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
                        child: const Text(
                          'Retake',
                          style: TextStyle(fontSize: 15),
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
                height: 350,
                width: 50,
              ),
            );
          });
        });
  }
}
