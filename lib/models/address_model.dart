import 'package:firebase_database/firebase_database.dart';

class FullAddress {
  final String city;
  final String district;
  final String provision;
  FullAddress(
      {required this.city, required this.district, required this.provision});
  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'district': district,
      'provision': provision,
    };
  }

  FullAddress.fromMap(addressMap)
      : city = addressMap["city"],
        district = addressMap["district"],
        provision = addressMap["provision"];

  FullAddress.fromDatabaseSnapshot(DataSnapshot dbsn)
      : city = dbsn.child('city').value.toString(),
        district = dbsn.child('district').value.toString(),
        provision = dbsn.child('provision').value.toString();
}
