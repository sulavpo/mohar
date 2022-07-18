import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohar_version/Constants/image.dart';
import 'package:mohar_version/custom/card.dart';

class BottomSheets {
  void bottomsheets(context) {
    showModalBottomSheet(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Padding(
              padding: const EdgeInsets.fromLTRB(3.0, 0, 3.0, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                      padding: const EdgeInsets.only(
                          left: 150.0, right: 150, top: 12),
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 216, 217, 219),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                      const Padding(
                        padding: EdgeInsets.only(right: 150.0, top: 30),
                        child: Text(
                          "Highest Contributor",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8.0),
                        height: 500,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: [
                            CardForm().cardField(
                                coin: "5000",
                                rank: "1st Rank",
                                name: "Suraj Pandey",
                                avatar: AppImages.avatar1),
                            CardForm().cardField(
                                coin: "4090",
                                rank: "2nd Rank",
                                name: "Sita Sharma",
                                avatar: AppImages.avatar4),
                            CardForm().cardField(
                                coin: "4002",
                                rank: "3rd Rank",
                                name: "Kaji Khadka",
                                avatar: AppImages.avatar3),
                            CardForm().cardField(
                                coin: "3990",
                                rank: "4th Rank",
                                name: "Rani Shah ",
                                avatar: AppImages.avatar5),
                            CardForm().cardField(
                                coin: "3560",
                                rank: "5th Rank",
                                name: "Ayush Shrestha",
                                avatar: AppImages.avatar3),
                            CardForm().cardField(
                                coin: "3230",
                                rank: "6th Rank",
                                name: "Sasen Maharjan",
                                avatar: AppImages.avatar2),
                            CardForm().cardField(
                                coin: "2890",
                                rank: "7th Rannk",
                                name: "Laxmi Sigdel",
                                avatar: AppImages.avatar1),
                            CardForm().cardField(
                                coin: "2745",
                                rank: "8th Rank",
                                name: "Nirajan khanal",
                                avatar: AppImages.avatar3),
                            CardForm().cardField(
                                coin: "2340",
                                rank: "9th Rank",
                                name: "Sumiran khafle",
                                avatar: AppImages.avatar4),
                            CardForm().cardField(
                                coin: "2240",
                                rank: "10th Rank",
                                name: "Ankit Raj Bahadur Baniya Adhakari",
                                avatar: AppImages.avatar1),
                          ],
                        ),
                      ),
                    ],
                  ),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                ),
              ),
            ));
  }
}
