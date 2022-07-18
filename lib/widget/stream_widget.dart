import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mohar_version/models/data_model.dart';

class StreamWidget extends StatefulWidget {
  const StreamWidget({Key? key, required this.callback}) : super(key: key);
  final Function(Data) callback;

  @override
  State<StreamWidget> createState() => _StreamWidgetState();
}

class _StreamWidgetState extends State<StreamWidget> {
  Data? recievedData;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = _auth.currentUser!.uid;

    return StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref("users/MfPFY5oPsEaozG0hsnTCkshYGtr1")
            .onValue,
        //initialData: 0,

        builder: (
          BuildContext context,
          AsyncSnapshot<DatabaseEvent> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('waiting');
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              recievedData = Data.fromDatabaseEvent(snapshot.data!);
              return widget.callback(recievedData!);
            }
          }
          return const Text('Kina bigriyo malai ni thaha chaina');
        });
  }
}
