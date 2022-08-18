import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mohar_version/custom/toast.dart';
// import 'package:mohar_version/models/data_model.dart';
import 'package:mohar_version/pages/google_signin.dart';
// import 'package:mohar_version/pages/home_page.dart';
import 'package:mohar_version/pages/login_page.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  Future<bool> getData(String mail) async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('users').get();

    return snap.docs.any((doc) => mail == doc["email"]);
  }

  AppBloc() : super(MoharInitialState()) {
    on<LoginEvent>((event, emit) async {
      emit(MoharLoadingState());
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(MoharLoggedinState());
      } catch (e) {
        emit(MoharLoggedinFailedState());
      }
    });
    on<InitialEvent>(((event, emit) {
      FirebaseAuth _auth = FirebaseAuth.instance;
      String? cid = _auth.currentUser?.uid;
      if (cid == null) {
        emit(MoharNotLoggedinState());
      } else {
        emit(MoharLoggedinState());
      }
    }));
    on<LogoutEvent>(((event, emit) async {
      try {
        await GoogleSignIn().disconnect();
        await FirebaseAuth.instance.signOut();
      } catch (e) {
        emit(MoharNotLoggedinState());
      }
    }));
    on<GoogleEvent>(((event, emit) async {
      final user = await GoogleSignIn().signIn();
      if (user == null) return;
      GoogleSignInAccount? loggedUser = user;
      final GoogleSignInAuthentication googleSignInAuthentication =
          await loggedUser.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      FirebaseAuth.instance.signInWithCredential(authCredential);
      bool exists = await getData(loggedUser.email);
      if (!exists) {
        Navigator.pushNamed(event.ctx, GoogleSignin.routeName,
            arguments: ScreenArguments(
                loggedUser.id, loggedUser.email, loggedUser.displayName!));
      } else {
        emit(MoharLoggedinState());
      }
    }));
    on<RegisterEvent>(((event, emit) {
      emit(MoharLoggedinState());
    }));
  }
}
