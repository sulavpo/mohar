import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohar_version/custom/update_dialouge.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class CustomRow {
  Widget customRow(
      {required String data,
      required String label,
      required String type,
      required BuildContext context}) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.blueGrey[500], borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label,
                style: const TextStyle(
                  color: Colors.black,
                )),
          ),
          Text(
            data,
            style: const TextStyle(color: Colors.black),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                doSomething(type: type);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                ShowDialouge().showDialouge(
                    city: "",
                    district: "",
                    provision: "",
                    text: label,
                    context: context,
                    data: data,
                    type: type,
                    text1: "",
                    text2: "",
                    text3: "");
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              )),
        ],
      ),
    );
  }

  Widget customAddress(
      {required String city,
      required String type,
      required String district,
      required String provision,
      required BuildContext context}) {
    return Container(
      height: 40,
      width: 500,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.blueGrey[500], borderRadius: BorderRadius.circular(5)),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            children: [
              padding("Address:", Colors.white),
              const SizedBox(
                width: 3,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  width: 165,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      padding("$city,", Colors.black),
                      padding("$district,", Colors.black),
                      padding(provision, Colors.black),
                      // const Spacer(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: IconButton(
                    onPressed: () {
                      doSomething(type: type);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
              ),
              IconButton(
                  onPressed: () {
                    ShowDialouge().showDialouge(
                        text: 'Address',
                        context: context,
                        data: "",
                        type: type,
                        text1: "City",
                        text2: "District",
                        text3: "Provision",
                        city: city,
                        provision: provision,
                        district: district);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Padding padding(String provision, Color colors) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 5),
      child: Text(
        provision,
        style: TextStyle(color: colors),
      ),
    );
  }
}

void doSomething({required String type}) async {
  String uid = _auth.currentUser!.uid;
  FirebaseDatabase.instance
      .ref("users/$uid")
      .child(type)
      .remove()
      .then((value) {
    print("Sucessfully Deleted");
  });
}
