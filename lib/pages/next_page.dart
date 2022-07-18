import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        if(state is MoharLoggedinState){
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Form(
                key: _fmKey,
                child: SingleChildScrollView(
                  physics: loading
                      ? const NeverScrollableScrollPhysics()
                      : const AlwaysScrollableScrollPhysics(),
                  child: SafeArea(
                      child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 25),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              Text(
                                '2/3',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 130, top: 25),
                        child: Text('Take a photo',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 160, top: 5),
                        child: Text('of your ID',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10.0, top: 15, bottom: 15),
                        child: SvgPicture.asset(
                          AppImages.camera,
                          width: 150,
                          height: 150,
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 8.0, top: 8.0, right: 230.0),
                        child: Text(
                          'Gender',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'male',
                          style: TextStyle(color: Colors.black),
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
                        title: const Text(
                          'female',
                          style: TextStyle(color: Colors.black),
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
                        title: const Text(
                          'Other',
                          style: TextStyle(color: Colors.black),
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
                        padding: const EdgeInsets.only(
                            left: 22, right: 22, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Document Type:',
                              style: TextStyle(fontSize: 15),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    isExpanded: true,
                                    hint: const Text(
                                      '\t\t\t\tSelect the Document Type',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    items: documentItems
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select document type.';
                                      }
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
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, top: 8.0),
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
                                      child: const Icon(
                                        Icons.image,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 35),
                                    child: Container(
                                      height: 30,
                                      width: 30,
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
                                          child: const Icon(
                                            Icons.camera,
                                            size: 25,
                                          )),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          shape: BoxShape.circle),
                                    ),
                                  )
                                ],
                              ),
                              height: 120,
                              width: 150,
                              decoration: BoxDecoration(
                                  image: (pickedImage1 != null)
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(pickedImage1!)
                                              as ImageProvider)
                                      : null,
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, top: 8.0),
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
                                      child: const Icon(
                                        Icons.image,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 35),
                                    child: Container(
                                      height: 30,
                                      width: 30,
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
                                          child: const Icon(
                                            Icons.camera,
                                            size: 25,
                                          )),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          shape: BoxShape.circle),
                                    ),
                                  )
                                ],
                              ),
                              width: 150,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  image: (pickedImage2 != null)
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(pickedImage2!)
                                              as ImageProvider)
                                      : null,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 60),
                            child: Text("Front View"),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 120),
                            child: const Text("Back View"),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
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
                              padding: const EdgeInsets.only(left: 110),
                              child: Row(
                                children: [
                                  const Text(
                                    'Next',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward,
                                    size: 20,
                                  )
                                ],
                              ),
                            )),
                      ),
                    ],
                  )),
                )),
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
                              children: [
                                const CircularProgressIndicator(),
                                const Text("Please Wait......")
                              ],
                            ))),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
