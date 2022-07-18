import 'package:flutter/material.dart';
import 'package:mohar_version/models/data_model.dart';


class PriceScreen extends StatefulWidget {
  final Data? receivedData;
  const PriceScreen({ Key? key, this.receivedData }) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
    );
  }
}