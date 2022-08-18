import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mohar_version/models/address_model.dart';

class Data {
  final String fullname;
  final FullAddress address;
  final String email;
  final String phone;
  final String gender;
  final String dctype;
  final String front;
  final String back;
  final String password;
  final String profile;
  double points = 0;
  double balance = 0;
  String? uid;

  static var empty;
  Data(
      this.fullname,
      this.address,
      this.email,
      this.phone,
      this.gender,
      this.dctype,
      this.front,
      this.back,
      this.password,
      this.profile,
      this.uid,
      this.points,
      this.balance);
  Map<String, dynamic> toMap() {
    return {
      'name': fullname,
      'address': address.toMap(),
      'email': email,
      'phone': phone,
      'gender': gender,
      'dctype': dctype,
      'front': front,
      'back': back,
      'password': password,
      'profile': profile,
      'uid': uid,
      'points': points,
      'balance': balance
    };
  }

  factory Data.fromJson(parsedJson) {
    return Data(
      parsedJson['name'].toString(),
      FullAddress.fromMap(parsedJson['address']),
      parsedJson['email'].toString(),
      parsedJson['phone'].toString(),
      parsedJson['gender'].toString(),
      parsedJson['dctype'].toString(),
      parsedJson['font'].toString(),
      parsedJson['back'].toString(),
      parsedJson['password'].toString(),
      parsedJson['profile'].toString(),
      parsedJson['uid'].toString(),
      parsedJson['points'].toDouble(),
      parsedJson['balance'].toDouble(),
    );
  }
  Data.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : fullname = doc.data()!["name"],
        address = FullAddress.fromMap(doc.data()!["address"]),
        email = doc.data()!["email"],
        phone = doc.data()!["phone"],
        gender = doc.data()!["gender"],
        dctype = doc.data()!["dctype"],
        front = doc.data()!['front'],
        back = doc.data()!["back"],
        password = doc.data()!["password"],
        profile = doc.data()!["profile"],
        uid = doc.data()!["uid"],
        points = doc.data()!["points"],
        balance = doc.data()!["balance"];

  Data.fromDatabaseEvent(DatabaseEvent db)
      : fullname = db.snapshot.child('name').value.toString(),
        address =
            FullAddress.fromDatabaseSnapshot(db.snapshot.child('address')),
        email = db.snapshot.child('email').value.toString(),
        phone = db.snapshot.child('phone').value.toString(),
        gender = db.snapshot.child('gender').value.toString(),
        dctype = db.snapshot.child('dctype').value.toString(),
        front = db.snapshot.child('front').value.toString(),
        back = db.snapshot.child('back').value.toString(),
        password = db.snapshot.child('password').value.toString(),
        profile = db.snapshot.child('profile').value.toString(),
        uid = db.snapshot.child('profile').value.toString(),
        //first the retrive data goes into string and then tries to parse/convert the number string to integer
        points =
            double.parse((db.snapshot.child('points').value ?? 0).toString()),
        balance = double.parse((db.snapshot.child('balance').value ?? 0).toString());
}
