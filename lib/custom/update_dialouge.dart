import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohar_version/custom/form.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class ShowDialouge {
  void showDialouge(
      {required String text,
      required String text1,
      required String text2,
      required String text3,
      required String city,
      required String district,
      required String provision,
      required String data,
      required String type,
      required BuildContext context}) {
    TextEditingController textContrl = TextEditingController();
    TextEditingController textContrl1 = TextEditingController();
    TextEditingController textContrl2 = TextEditingController();
    TextEditingController textContrl3 = TextEditingController();
    textContrl.text = data;
    textContrl1.text = city;
    textContrl2.text = district;
    textContrl3.text = provision;

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () {
                      if (city == "") {
                      doAnything(type: type, input: textContrl);
                        Navigator.pop(context);
                      } else {
                       doOnething(
                            type: type,
                            input1: textContrl1,
                            input2: textContrl2,
                            input3: textContrl3);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
              backgroundColor: Theme.of(context).brightness == Brightness.dark? Colors.black:Colors.blueGrey[50],
              content: SizedBox(
                  width: 100,
                  child: (city == '')
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(text),
                            TextForm().formField(
                                label: text,
                                icon: const Icon(Icons.password),
                                type: textContrl)
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(text1),
                            TextForm().formField(
                                label: city,
                                icon: const Icon(Icons.edit),
                                type: textContrl1),
                            Text(text2),
                            TextForm().formField(
                                label: district,
                                icon: const Icon(Icons.edit),
                                type: textContrl2),
                            Text(text3),
                            TextForm().formField(
                                label: provision,
                                icon: const Icon(Icons.edit),
                                type: textContrl3),
                          ],
                        )),
            ));
  }
}

void doAnything(
    {required String type, required TextEditingController input}) async {
  String uid = _auth.currentUser!.uid;
  FirebaseDatabase.instance
      .ref("users/$uid")
      .update({type: input.text}).then((value) {
    print("Sucessfully Updated");
  });
}

void doOnething(
    {required TextEditingController input1,
    required String type,
    required TextEditingController input2,
    required TextEditingController input3}) async {
  String uid = _auth.currentUser!.uid;
  FirebaseDatabase.instance.ref("users/$uid").update({
    type: {
      "city": input1.text,
      "district": input2.text,
      "provision": input3.text
    }
  }).then((value) {
    print("Sucessfully Updated");
  });
}
