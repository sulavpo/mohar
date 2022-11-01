import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineTiles {
  static getTitleData(BuildContext ctx) => FlTitlesData(
      show: true,
      topTitles: AxisTitles(
          sideTitles: SideTitles(
              reservedSize: 32,
              showTitles: true,
              getTitlesWidget: (value, title) {
                return const Text('');
              },
              interval: 5)),
      rightTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, title) {
                return const Text('');
              },
              interval: 5)),
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              reservedSize: 32,
              showTitles: true,
              getTitlesWidget: (value, title) {
                switch (value.toInt()) {
                  case 1:
                    return Text(
                      "Sun",
                      style: TextStyle(color:Theme.of(ctx).brightness == Brightness.light? const Color.fromARGB(255, 64, 64, 64):Colors.white, fontSize: 10),
                    );
                  case 2:
                    return Text('Mon',
                        style: TextStyle(color: Theme.of(ctx).brightness == Brightness.light? const Color.fromARGB(255, 64, 64, 64):Colors.white, fontSize: 10));
                  case 3:
                    return Text('Tue',
                        style: TextStyle(color: Theme.of(ctx).brightness == Brightness.light? const Color.fromARGB(255, 64, 64, 64):Colors.white, fontSize: 10));
                  case 4:
                    return Text('Wed',
                        style: TextStyle(color: Theme.of(ctx).brightness == Brightness.light? const Color.fromARGB(255, 64, 64, 64):Colors.white, fontSize: 10));
                  case 5:
                    return Text('Thus',
                        style: TextStyle(color: Theme.of(ctx).brightness == Brightness.light? const Color.fromARGB(255, 64, 64, 64):Colors.white, fontSize: 10));
                  case 6:
                    return Text('Fri',
                        style: TextStyle(color: Theme.of(ctx).brightness == Brightness.light? const Color.fromARGB(255, 64, 64, 64):Colors.white, fontSize: 10));
                  case 7:
                    return Text('Sat',
                        style: TextStyle(color: Theme.of(ctx).brightness == Brightness.light? const Color.fromARGB(255, 64, 64, 64):Colors.white, fontSize: 10));
                }
                return const Text('');
              },
              interval: 1)),
      // leftTitles: AxisTitles(
      //     sideTitles: SideTitles(
      //         showTitles: true,
      //         getTitlesWidget: (value, title) {
      //           switch (value.toInt()) {
      //             case 1:
      //               return Text(
      //                 "0",
      //                 style: TextStyle(color: Colors.white, fontSize: 10),
      //               );
      //             case 500:
      //               return Text(
      //                 "500",
      //                 style: TextStyle(color: Colors.white, fontSize: 10),
      //               );
      //             case 3:
      //               return Text('1k',
      //                   style: TextStyle(color: Colors.white, fontSize: 10));
      //             case 4:
      //               return Text('1.5k',
      //                   style: TextStyle(color: Colors.white, fontSize: 10));
      //             case 5:
      //               return Text('2k',
      //                   style: TextStyle(color: Colors.white, fontSize: 10));
      //             case 6:
      //               return Text('2.5k',
      //                   style: TextStyle(color: Colors.white, fontSize: 10));
      //             case 7:
      //               return Text('5k',
      //                   style: TextStyle(color: Colors.white, fontSize: 10));
      //           }
      //           return Text('');
      //         },
      //         interval: 3)
      //         )
              );
}
