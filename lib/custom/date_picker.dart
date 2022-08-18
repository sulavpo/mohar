// import 'package:flutter/material.dart';

// class PickDate extends StatefulWidget {
//   const PickDate({Key? key, this.restorationId}) : super(key: key);

//   final String? restorationId;

//   @override
//   State<PickDate> createState() => _PickDateState();
// }

// /// RestorationProperty objects can be used because of RestorationMixin.
// class _PickDateState extends State<PickDate>
//     with RestorationMixin {
//   // In this example, the restoration ID for the mixin is passed in through
//   // the [StatefulWidget]'s constructor.
//   @override
//   String? get restorationId => widget.restorationId;

//   final RestorableDateTime _selectedDate =
//       RestorableDateTime(DateTime(2021, 7, 25));
//   late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
//       RestorableRouteFuture<DateTime?>(
//     onComplete: _selectDate,
//     onPresent: (NavigatorState navigator, Object? arguments) {
//       return navigator.restorablePush(
//         _datePickerRoute,
//         arguments: _selectedDate.value.millisecondsSinceEpoch,
//       );
//     },
//   );

//   static Route<DateTime> _datePickerRoute(
//     BuildContext context,
//     Object? arguments,
//   ) {
//     return DialogRoute<DateTime>(
//       context: context,
//       builder: (BuildContext context) {
//         return DatePickerDialog(
//           restorationId: 'date_picker_dialog',
//           initialEntryMode: DatePickerEntryMode.calendarOnly,
//           initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
//           firstDate: DateTime(2021),
//           lastDate: DateTime(2022),
//         );
//       },
//     );
//   }

//   @override
//   void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//     registerForRestoration(_selectedDate, 'selected_date');
//     registerForRestoration(
//         _restorableDatePickerRouteFuture, 'date_picker_route_future');
//   }

//   void _selectDate(DateTime? newSelectedDate) {
//     if (newSelectedDate != null) {
//       setState(() {
//         _selectedDate.value = newSelectedDate;
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(
//               'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
//         ));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(onTap: (){
//       _restorableDatePickerRouteFuture.present();
//     },
//       child: Icon(Icons.calendar_today));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickDate extends StatefulWidget {
  const PickDate({Key? key}) : super(key: key);

  @override
  State<PickDate> createState() => _PickDateState();
}

class _PickDateState extends State<PickDate> {
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 11, 5), end: DateTime(2022, 11, 5));
  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    return SizedBox(
      height: 40.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              Text("Date Range:",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold)),  SizedBox(
            width: 12.w,
          ),
          ElevatedButton(
           child: Text(
          "${start.year}/${start.month}/${start.day}",style: TextStyle(fontSize: 10.sp),
            ),
            onPressed: pickDateRange,
          ),
           SizedBox(
            width: 12.w,
          ),
          ElevatedButton(
            child: Text(
          "${end.year}/${end.month}/${end.day}",style: TextStyle(fontSize: 10.sp)
            ),
            onPressed: pickDateRange,
          )
        ],
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        initialDateRange: dateRange);
    if (newDateRange == null) return;
    setState(() {
      dateRange = newDateRange;
    });
  }
}
