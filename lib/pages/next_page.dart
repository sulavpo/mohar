import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohar_version/Constants/image.dart';
import 'package:mohar_version/bloc/app_bloc.dart';
import 'package:mohar_version/models/next_page_view.dart';
import 'package:mohar_version/pages/selfie_page.dart';

import '../custom/toast.dart';

class NextArgument {
  String? email;
  String? fullname;
  String? password;
  String? phone;
  String? address;
  String? gender;
  String? dctype;
  String? front;
  String? back;
  bool? test;

  NextArgument({
    this.email,
    this.fullname,
    this.address,
    this.password,
    this.back,
    this.dctype,
    this.front,
    this.gender,
    this.phone,
    this.test,
  });
}

enum SingingCharacter { male, female, other }

class NextPage extends StatefulWidget {
  final NextPageViewModel arguments;
  const NextPage({Key? key, required this.arguments}) : super(key: key);
  static const routeName = "/Next-Page";

  @override
  State<NextPage> createState() => _NextPageState();
}

class ImageModel {
  bool isFront;
  String imageUrl;
  ImageModel({required this.imageUrl, required this.isFront});
}

class _NextPageState extends State<NextPage> {
  Future<List<ImageModel>> uploadFile() async {
    final path1 = '/front/${pickedXfile1!.name}';
    final path2 = '/back/${pickedXfile2!.name}';
    List<ImageModel> images = [];
    // final file1 = File(pickedImage1!.path);
    // final file2 = File(pickedImage2!.path);

    final ref1 = FirebaseStorage.instance.ref().child(path1);
    await ref1.putFile(pickedImage1!);
    image1Url = await ref1.getDownloadURL();

    final ref2 = FirebaseStorage.instance.ref().child(path2);
    await ref2.putFile(pickedImage2!);
    image2Url = await ref2.getDownloadURL();
    images.add(ImageModel(imageUrl: image1Url!, isFront: true));
    images.add(ImageModel(imageUrl: image2Url!, isFront: false));
    return images;
    // final results = await File(pickedImage1!.path);
  }

  SingingCharacter? _character = SingingCharacter.male;

  // String? file = "cc";

  final List<String> documentItems = [
    "Citizenship card",
    "Driver's Licence",
    "Passport Page Photo"
  ];
  String? image1Url;
  String? image2Url;
  XFile? pickedXfile1, pickedXfile2;

  String? selectedValue;
  bool loading = false;
  final _fmKey = GlobalKey<FormState>();

  File? pickedImage1;
  File? pickedImage2;
  static Future<XFile?> _pickImage(ImageSource imageSource) async {
    return await ImagePicker().pickImage(source: imageSource);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is MoharLoggedinState) {
          Navigator.pop(context);
        }
      },
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: Colors.white,
          body: Stack(
            children: [
              Form(
                  key: _fmKey,
                  child: SingleChildScrollView(
                    physics: loading
                        ? const NeverScrollableScrollPhysics()
                        : const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.w, right: 20.w, top: 25.h),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            Text(
                              '2/3',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 130.w, top: 25.h),
                      child: Text('Take a photo',
                          style: TextStyle(
                              fontSize: 30.sp, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 160.w, top: 5.h),
                      child: Text('of your ID',
                          style: TextStyle(
                              fontSize: 30.sp, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 10.0.w, top: 15.h, bottom: 15.h),
                      child: SvgPicture.asset(
                        AppImages.camera,
                        width: 150.w,
                        height: 150.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 8.0.w, top: 8.0.h, right: 230.0.w),
                      child: Text(
                        'Gender',
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : const Color.fromARGB(255, 23, 23, 23),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'male',
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : const Color.fromARGB(255, 23, 23, 23),
                        ),
                      ),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.male,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'female',
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : const Color.fromARGB(255, 23, 23, 23),
                        ),
                      ),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.female,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Other',
                        style: TextStyle(
                            color: Theme.of(context).brightness ==
                                    Brightness.dark
                                ? Colors.white
                                : const Color.fromARGB(255, 23, 23, 23)),
                      ),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.other,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 22.w, right: 22.w, bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Document Type:',
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(5.w, 0.h, 0.w, 0.h),
                              child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.r),
                                    ),
                                  ),
                                  isExpanded: true,
                                  hint: Text(
                                    '\t\t\t\tSelect the Document Type',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : const Color.fromARGB(255, 23, 23, 23),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color.fromARGB(255, 23, 23, 23)
                                        : Colors.white,
                                  ),
                                  items: documentItems
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.0.w),
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select document type.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    selectedValue = value.toString();
                                  },
                                  onChanged: (value) {}),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15.0.sp),
                          child: Container(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0.w, top: 8.0.h),
                                  child: InkWell(
                                    onTap: () async {
                                      pickedXfile1 = await _pickImage(
                                          ImageSource.gallery);
                                      if (pickedXfile1 != null) {
                                        setState(() {
                                          pickedImage1 =
                                              File(pickedXfile1!.path);
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Icons.image,
                                      size: 30.sp,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 8.0.h, left: 35.w),
                                  child: Container(
                                    height: 30.h,
                                    width: 30.w,
                                    child: InkWell(
                                        onTap: () async {
                                          pickedXfile1 = await _pickImage(
                                              ImageSource.camera);
                                          if (pickedXfile1 != null) {
                                            setState(() {
                                              pickedImage1 =
                                                  File(pickedXfile1!.path);
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.camera,
                                          size: 25.sp,
                                        )),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        shape: BoxShape.circle),
                                  ),
                                )
                              ],
                            ),
                            height: 120.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                                image: (pickedImage1 != null)
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(pickedImage1!))
                                    : null,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey.withOpacity(0.5)
                                    : Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20.r)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0.sp),
                          child: Container(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0.w, top: 8.0.h),
                                  child: InkWell(
                                    onTap: () async {
                                      pickedXfile2 = await _pickImage(
                                          ImageSource.gallery);
                                      if (pickedXfile2 != null) {
                                        setState(() {
                                          pickedImage2 =
                                              File(pickedXfile2!.path);
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Icons.image,
                                      size: 30.sp,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 8.0.h, left: 35.w),
                                  child: Container(
                                    height: 30.h,
                                    width: 30.w,
                                    child: InkWell(
                                        onTap: () async {
                                          pickedXfile2 = await _pickImage(
                                              ImageSource.camera);
                                          if (pickedXfile2 != null) {
                                            setState(() {
                                              pickedImage2 =
                                                  File(pickedXfile2!.path);
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.camera,
                                          size: 25.sp,
                                        )),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        shape: BoxShape.circle),
                                  ),
                                )
                              ],
                            ),
                            width: 150.w,
                            height: 120.h,
                            decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey.withOpacity(0.5)
                                    : Colors.green.withOpacity(0.1),
                                image: (pickedImage2 != null)
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(pickedImage2!))
                                    : null,
                                borderRadius: BorderRadius.circular(20.r)),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 60.w),
                          child: const Text("Front View"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 120.w),
                          child: const Text("Back View"),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30.w, 20.h, 30.w, 0.h),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(10.sp)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.r)),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 87, 151, 203))),
                          onPressed: (() async {
                            if (_fmKey.currentState!.validate()) {
                              _fmKey.currentState!.save();
                              if (pickedImage1 == null ||
                                  pickedImage2 == null) {
                                return Toasts.showToast(
                                    "Please select Image of the Documents",
                                    Colors.red);
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                List<ImageModel> images = await uploadFile();
      
                                setState(() {
                                  loading = false;
                                });
                                Navigator.pushNamed(context, SelfieClick.routeName,
                                    arguments: (widget.arguments.signupArguments != null)
                                        ? NextArgument(
                                            email: widget.arguments
                                                .signupArguments!.email,
                                            address: widget.arguments
                                                .signupArguments!.address,
                                            password: widget.arguments
                                                .signupArguments!.password,
                                            phone: widget.arguments
                                                .signupArguments!.phone,
                                            fullname: widget.arguments
                                                .signupArguments!.name,
                                            gender: _character
                                                .toString()
                                                .split('.')
                                                .last,
                                            dctype: selectedValue,
                                            front: images[0].imageUrl,
                                            back: images[1].imageUrl,
                                            test: (widget.arguments
                                                    .signupArguments !=
                                                null))
                                        : NextArgument(
                                            email: widget.arguments.gogArguments!.email,
                                            address: widget.arguments.gogArguments!.address,
                                            password: widget.arguments.gogArguments!.password,
                                            phone: widget.arguments.gogArguments!.phone,
                                            fullname: widget.arguments.gogArguments!.fullname,
                                            gender: _character.toString().split('.').last,
                                            dctype: selectedValue,
                                            front: images[0].imageUrl,
                                            back: images[1].imageUrl,
                                            test: (widget.arguments.signupArguments != null)));
                              }
                            }
                            // });
                          }),
                          child: Padding(
                            padding: EdgeInsets.only(left: 110.w),
                            child: Row(
                              children: [
                                Text(
                                  'Next',
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 20.sp,
                                )
                              ],
                            ),
                          )),
                    ),
                    SizedBox(height:10.h)
                      ],
                    ),
                  )),
              loading
                  ? Container(
                      height: double.infinity.h,
                      color: Colors.black.withOpacity(0.4),
                      child: Center(
                          child: Container(
                              padding: EdgeInsets.all(40.sp),
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
          ),
        ),
      ),
    );
  }
}
