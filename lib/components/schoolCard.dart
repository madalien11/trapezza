import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trapezza/classes/date.dart';
import 'package:trapezza/data/data.dart';
import 'dart:ui';
import 'package:trapezza/screens/week.dart';

int schoolId;

class SchoolCard extends StatefulWidget {
  final String title;
  final int id;
  final Function callBack;
  SchoolCard(
      {@required this.title, @required this.id, @required this.callBack});

  @override
  _SchoolCardState createState() => _SchoolCardState();
}

class _SchoolCardState extends State<SchoolCard> {
  List<Date> _dates = [];
  bool _isDisabled;

  Future getSchoolDates(schoolId) async {
    var response = await Dates(id: schoolId).getData();
    if (response != null) {
      List datesList = response['data'];
      if (!mounted) return;
      setState(() {
        for (var date in datesList) {
          Date s = Date(
            id: date['id'],
            name: date['name'],
            week: date['week'],
            date: date['date'],
            today: date['today'],
          );
          _dates.add(s);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _isDisabled = false;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return InkWell(
      onTap: _isDisabled
          ? () => print('')
          : () async {
              if (!mounted) return;
              setState(() {
                _isDisabled = true;
              });
              widget.callBack();
              schoolId = widget.id;
              await getSchoolDates(schoolId);
              Navigator.pushNamed(context, WeekScreen.id, arguments: {
                'id': widget.id,
                'dates': _dates,
                'schoolName': widget.title
              });
              widget.callBack();
              if (!mounted) return;
              setState(() {
                _isDisabled = false;
              });
            },
      child: Container(
        height: 50.h,
        margin: EdgeInsets.all(8.w),
        child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff2C2E5E)),
                ),
              ),
            ))),
      ),
    );
  }
}
