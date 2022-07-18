import 'package:flutter/material.dart';
import 'package:mohar_version/models/data_model.dart';

class StatusScreen extends StatefulWidget {
  final Data? receivedData;
  const StatusScreen({Key? key,  this.receivedData}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amber,
    );
  }
}
