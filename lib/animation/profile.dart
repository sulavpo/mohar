import 'package:flutter/material.dart';
import 'package:mohar_version/models/data_model.dart';
import 'package:mohar_version/pages/profile_screen.dart';

class ProfilePage extends StatefulWidget {
  final Data? receivedData;
  const ProfilePage({Key? key, this.receivedData}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    {


 

  

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      receivedData: widget.receivedData,

    );
  }
}
