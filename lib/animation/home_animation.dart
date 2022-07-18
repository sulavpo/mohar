import 'package:flutter/material.dart';

class HomePageEnterAnimation {
  HomePageEnterAnimation(this.controller)
      : barHeight = Tween<double>(begin: 0, end: 170).animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.3, curve: Curves.easeIn))),
        avatarSize = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.3, 0.6, curve: Curves.elasticInOut))),
        tittleOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 0.65, curve: Curves.easeIn))),
        textOpacity = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: controller, curve: const Interval(0.65, 0.8)));
  final AnimationController controller;
  final Animation<double> barHeight;
  final Animation<double> avatarSize;
  final Animation<double> tittleOpacity;
  final Animation<double> textOpacity;
}
