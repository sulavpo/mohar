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
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
      _controller.dispose(); 

  }

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      controller: _controller,
      receivedData: widget.receivedData,

    );
  }
}
