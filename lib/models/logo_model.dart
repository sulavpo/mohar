import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohar_version/Constants/image.dart';

List<LogoPart> logoPartList = <LogoPart>[
  LogoPart(
    title: 'Bio-Decay',
    iconName: AppImages.bio,
    onTap: () {},
  ),
  LogoPart(
    title: 'Recycle',
    iconName: AppImages.recycle,
    onTap: () {},
  ),
  LogoPart(
    title: 'Plastic',
    iconName: AppImages.plastic,
    onTap: () {},
  ),
  LogoPart(
    title: 'Eco-Brick',
    iconName: AppImages.bottle,
    onTap: () {},
  ),
  LogoPart(
    title: 'Rewards',
    iconName: AppImages.reward,
    onTap: () {},
  ),
];

List<LogoPart> withDrawList = <LogoPart>[
  LogoPart(
    title: 'Withdraw',
    iconName: AppImages.withdraw,
    onTap: () {},
  ),
  LogoPart(
    title: 'Statement',
    iconName: AppImages.statement,
    onTap: () {},
  ),
  LogoPart(
    title: 'More',
    iconName: AppImages.more,
    onTap: () {},
  ),
 
];
class LogoPart extends StatelessWidget {
  final String title;
  final String iconName;
  final Color color;
  final void Function() onTap;

  const LogoPart(
      {Key? key,
      required this.title,
      required this.iconName,
      this.color = Colors.white,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(iconName,height: 10,width: 10,),
            ),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(title),
          )
        ],
      ),
    );
  }
}
