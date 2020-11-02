import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trapezza/classes/meal.dart';
import 'package:trapezza/data/data.dart';
import 'dart:ui';
import 'package:trapezza/screens/tables.dart';
import 'schoolCard.dart';
import 'package:trapezza/screens/week.dart';

var months = [
  "Января",
  "Февраля",
  "Марта",
  "Апреля",
  "Мая",
  "Июня",
  "Июля",
  "Августа",
  "Сентября",
  "Октября",
  "Ноября",
  "Декабря",
];

var _shortMonths = [
  "янв.",
  "фев.",
  "мар.",
  "апр.",
  "мая",
  "июня",
  "июля",
  "авг.",
  "сен.",
  "окт.",
  "ноя.",
  "дек.",
];

String imageUrl = 'mon';
int containerColor = 0xffFFF0BC;
int textColor = 0xffF2BD00;

class WeekdayCard extends StatefulWidget {
  final String name;
  final int id;
  final int week;
  final String date;
  final bool today;
  final bool fromMeals;
  final Function callBack;
  WeekdayCard(
      {this.name,
      this.id,
      this.today,
      this.date,
      this.week,
      @required this.fromMeals,
      this.callBack});

  @override
  _WeekdayCardState createState() => _WeekdayCardState();
}

class _WeekdayCardState extends State<WeekdayCard> {
  bool _isDisabled;
  List<Meal> _tables = [];

  Future getTables(schoolId, day) async {
    var response = await Menu(school: schoolId, day: day).getData();
    if (response != null) {
      List tablesList = response['data'];
      if (!mounted) return;
      setState(() {
        for (var table in tablesList) {
          Meal s = Meal(
            id: table['id'],
            name: table['name'],
            subtitle: table['category']['name'],
            description: table['description'],
            imageUrl: table['img'],
          );
          _tables.add(s);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _isDisabled = false;
    if (_tables != null) _tables.clear();
  }

  @override
  void dispose() {
    super.dispose();
    if (_tables != null) _tables.clear();
  }

  @override
  Widget build(BuildContext context) {
    var theDate = DateTime.parse(widget.date.substring(0, 19));
    var todayDate = DateTime.now();
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    if (widget.name == 'Вторник') {
      imageUrl = 'tue';
      containerColor = 0xffDCF7FE;
      textColor = 0xff44A5B8;
    } else if (widget.name == 'Среда') {
      imageUrl = 'wed';
      containerColor = 0xffFBE5CF;
      textColor = 0xffF2943A;
    } else if (widget.name == 'Четверг') {
      imageUrl = 'thu';
      containerColor = 0xffF2D1FE;
      textColor = 0xffC061E1;
    } else if (widget.name == 'Пятница') {
      imageUrl = 'fri';
      containerColor = 0xffD0F9BE;
      textColor = 0xff45CD08;
    } else if (widget.name == 'Суббота') {
      imageUrl = 'sat';
      containerColor = 0xffFFB1DB;
      textColor = 0xffDD4296;
    } else if (widget.name == 'Воскресенье') {
      imageUrl = 'sun';
      containerColor = 0xffC5D1FF;
      textColor = 0xff5E7ADF;
    } else {
      imageUrl = 'mon';
      containerColor = 0xffFFF0BC;
      textColor = 0xffF2BD00;
    }
    return widget.fromMeals
        ? InkWell(
            onTap: _isDisabled
                ? () => print('')
                : () async {
                    if (!mounted) return;
                    setState(() {
                      _isDisabled = true;
                    });
                    widget.callBack();
                    pressedId = widget.id;
                    if (_tables != null) _tables.clear();
                    await getTables(schoolId, widget.id);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, TablesScreen.id,
                        arguments: {'weekday': widget.name, 'tables': _tables});
                    widget.callBack();
                    if (!mounted) return;
                    setState(() {
                      _isDisabled = false;
                    });
                  },
            child: Container(
              height: 120.w,
              width: 80.w,
              margin: EdgeInsets.all(2.w),
              child: Card(
                elevation: pressedId == widget.id ? 5 : 1,
                shape: pressedId == widget.id
                    ? RoundedRectangleBorder(
                        side: BorderSide(color: Color(textColor), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)))
                    : RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 0),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(containerColor),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.w, right: 15.w, top: 15.h),
                            child: Image.asset(
                              "images/" + imageUrl + ".png",
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h, bottom: 1.h),
                            child: Text(
                                theDate.day.toString() +
                                    ' ' +
                                    _shortMonths[theDate.month - 1],
                                style: TextStyle(
                                    color: Color(textColor).withOpacity(0.74),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : InkWell(
            onTap: _isDisabled
                ? () => print('')
                : () async {
                    if (!mounted) return;
                    setState(() {
                      _isDisabled = true;
                    });
                    widget.callBack();
                    pressedId = widget.id;
                    if (_tables != null) _tables.clear();
                    await getTables(schoolId, widget.id);
                    Navigator.pushNamed(context, TablesScreen.id,
                        arguments: {'weekday': widget.name, 'tables': _tables});
                    widget.callBack();
                    if (!mounted) return;
                    setState(() {
                      _isDisabled = false;
                    });
                  },
            child: Container(
              height: 160.w,
              width: 160.w,
              margin: EdgeInsets.all(8.w),
              child: Card(
                elevation: widget.today ? 5 : 1,
                shape: widget.today
                    ? RoundedRectangleBorder(
                        side: BorderSide(color: Color(textColor), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)))
                    : RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 0),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(containerColor),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/" + imageUrl + ".png",
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h, bottom: 1.h),
                            child: Text(widget.name,
                                style: TextStyle(
                                    color: Color(textColor),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700)),
                          ),
                          Text(
                              widget.today
                                  ? 'Сегодня'
                                  : theDate.day - 1 == todayDate.day
                                      ? 'Завтра'
                                      : theDate.day.toString() +
                                          ' ' +
                                          months[theDate.month - 1],
                              style: TextStyle(
                                  color: Color(textColor).withOpacity(0.74),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
