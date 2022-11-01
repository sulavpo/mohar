import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mohar_version/models/data_model.dart';

class PriceScreen extends StatefulWidget {
  final Data? receivedData;
  const PriceScreen({Key? key, this.receivedData}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Center(
        child: Animate(
            effects: const [
              FadeEffect(),
              ScaleEffect()
            ],
            child: const Text(
              'Hello World',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            )
                .animate()
                .fadeIn(delay: 300.ms, duration: 500.ms)
                .then() // sets own delay to 800ms (300+500)
                .slide(duration: 400.ms) // inherits the 800ms delay
                .then(delay: 200.ms) // sets delay to 1400ms (800+400+200)
                // .blur() // inherits the 1400ms delay
                // Explicitly setting delay overrides the inherited value.
                // This move effect will run BEFORE the initial fade:
                .move(delay: 0.ms)),
      ),
    );
  }
}
