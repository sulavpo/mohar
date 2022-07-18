import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

part 'user_event.dart';
part 'user_state.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UpdateEvent>((event, emit) {
      String uid = _auth.currentUser!.uid;
      FirebaseDatabase.instance
          .ref("users/$uid")
          .update({event.type: event.input.text}).then((value) {
        print("Sucessfully Updated");
      });

      // TODO: implement event handler
    });
    on<AddressUpdateEvent>(((event, emit) {
      String uid = _auth.currentUser!.uid;
      FirebaseDatabase.instance.ref("users/$uid").update({
        event.type: {
          "city": event.input1.text,
          "district": event.input2.text,
          "provision": event.input3.text
        }
      }).then((value) {
        print("Sucessfully Updated");
      });
    }));
    on<DeleteEvent>(((event, emit) {
       String uid = _auth.currentUser!.uid;
  FirebaseDatabase.instance.ref("users/$uid").child(event.type).remove().then((value) {
    print("Sucessfully Deleted");
  });

    }));
  }
}
