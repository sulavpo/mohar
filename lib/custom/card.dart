import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohar_version/Constants/image.dart';

class CardForm {
  Widget cardField({
    required String coin,
    required String rank,
    required String name,
    required String avatar
  }) {
    return Card(
      // padding: const EdgeInsets.all(8.0),
      elevation: 2.5,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: SvgPicture.asset(
                    avatar,
                    fit: BoxFit.fill,
                  )),
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  color: Colors.red.withOpacity(0.2)),
            ),
            SizedBox(width: 50,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(rank,style: TextStyle(fontSize: 10),),
                    SizedBox(height: 5,),
                   Text(
                     name,
                     style: TextStyle(
                         fontWeight: FontWeight.bold, fontSize: 15),
                   ),
                   SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppImages.coin,
                        width: 10,
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(coin),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
