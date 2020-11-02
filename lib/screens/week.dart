import 'package:flutter/material.dart';
import 'package:trapezza/components/weekdayCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:trapezza/classes/date.dart';

int globalIndex = -1;
List<int> datesId = [];
List<Date> dates = [];
int pressedId;

class WeekScreen extends StatefulWidget {
  static const String id = 'week_screen';
  @override
  _WeekScreenState createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  Future<List<Date>> futureDatesList;
  bool thisWeek = true;
  List<Widget> datesWidgets1 = [];
  List<Widget> datesWidgets2 = [];
  bool loading = false;
  String schoolName;
  bool _hasData = true;

  void loader() {
    if (!mounted) return;
    setState(() {
      loading = !loading;
    });
  }

//  Widget futureBuilder(context, snapshot) {
//    if (snapshot.hasData) {
//      return ListView.builder(
//        // ignore: missing_return
//        itemBuilder: (context, index) {
//          bool even = false;
//          bool last = false;
//          if (snapshot.data.length % 2 == 0) {
//            even = true;
//            globalIndex += 2;
//          } else {
//            even = false;
//            if (globalIndex + 2 == snapshot.data.length) {
//              globalIndex++;
//              last = true;
//            } else {
//              last = false;
//              globalIndex += 2;
//            }
//          }
////                  print(snapshot.data.length);
//
//          index = globalIndex;
//          if (even && globalIndex < snapshot.data.length) {
//            return Row(
//              children: [
//                WeekdayCard(
//                  id: snapshot.data[index - 1].id,
//                  name: snapshot.data[index - 1].name,
//                  week: snapshot.data[index - 1].week,
//                  date: snapshot.data[index - 1].date,
//                  today: snapshot.data[index - 1].today,
//                ),
//                WeekdayCard(
//                  id: snapshot.data[index].id,
//                  name: snapshot.data[index].name,
//                  week: snapshot.data[index].week,
//                  date: snapshot.data[index].date,
//                  today: snapshot.data[index].today,
//                ),
//              ],
//            );
//          } else {
//            if (last) {
//              return Row(
//                children: [
//                  WeekdayCard(
//                    id: snapshot.data[index].id,
//                    name: snapshot.data[index].name,
//                    week: snapshot.data[index].week,
//                    date: snapshot.data[index].date,
//                    today: snapshot.data[index].today,
//                  ),
//                ],
//              );
//            } else if (!last && globalIndex < snapshot.data.length) {
//              return Row(
//                children: [
//                  WeekdayCard(
//                    id: snapshot.data[index - 1].id,
//                    name: snapshot.data[index - 1].name,
//                    week: snapshot.data[index - 1].week,
//                    date: snapshot.data[index - 1].date,
//                    today: snapshot.data[index - 1].today,
//                  ),
//                  WeekdayCard(
//                    id: snapshot.data[index].id,
//                    name: snapshot.data[index].name,
//                    week: snapshot.data[index].week,
//                    date: snapshot.data[index].date,
//                    today: snapshot.data[index].today,
//                  ),
//                ],
//              );
//            }
//          }
//        },
//        itemCount: snapshot.data.length,
//      );
//    } else if (snapshot.hasError) {
//      return Text("${snapshot.error}");
//    }
//    // By default, show a loading spinner.
//    return Center(
//        child: CircularProgressIndicator(backgroundColor: Color(0xff2C2E5E)));
//  }
//
//  void callDates() async {
//    var response = await Dates(id: schoolId).getData();
//    if (response != null) {
//      List datesList = response['data'];
//      if (!mounted) return;
//      setState(() {
//        for (var date in datesList) {
//          Date s = Date(
//            id: date['id'],
//            name: date['name'],
//            week: date['week'],
//            date: date['date'],
//            today: date['today'],
//          );
//          dates.add(s);
//        }
//      });
////      widgetBuilder();
//    }
//  }

  bool checkAddDate(i) {
    if (!datesId.contains(i)) {
      datesId.add(i);
      return true;
    } else
      return false;
  }

  List<Widget> widgetBuilder(dates) {
    for (var date in dates) {
      if (!mounted) return [];
      setState(() {
        if (checkAddDate(date.id)) {
          if (date.week == 1)
            datesWidgets1.add(WeekdayCard(
              fromMeals: false,
              id: date.id,
              name: date.name,
              week: date.week,
              date: date.date,
              today: date.today,
              callBack: loader,
            ));
          else if (date.week == 2)
            datesWidgets2.add(WeekdayCard(
              fromMeals: false,
              id: date.id,
              name: date.name,
              week: date.week,
              date: date.date,
              today: date.today,
              callBack: loader,
            ));
        }
      });
    }
    if (datesWidgets1.length < 1 && datesWidgets2.length < 1) _hasData = false;
    return thisWeek ? datesWidgets1 : datesWidgets2;
//    return datesWidgets2;
  }

  @override
  void dispose() {
    super.dispose();
    if (datesId != null) datesId.clear();
    if (dates != null) dates.clear();
    loading = false;
    _hasData = true;
  }

  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    if (map != null) if (map['dates'] != null) dates = map['dates'];
    if (map != null) if (map['schoolName'] != null)
      schoolName = map['schoolName'];
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Scaffold(
      backgroundColor: Color(0xffFDFDFD),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFDFDFD),
        toolbarHeight: 130.h,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 20.w,
                    color: Color(0xff2C2E5E),
                  ),
                  Text(
                    'Школы',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff2C2E5E),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.h),
            Center(
              child: Text(
                'Дни Недели',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff2C2E5E),
                ),
              ),
            ),
//            Padding(
//              padding: EdgeInsets.only(top: 4.h),
//              child: Center(
//                child: Text(
//                  schoolName.toString(),
//                  style: TextStyle(
//                    fontSize: 12.sp,
//                    fontWeight: FontWeight.w400,
//                    color: Color(0xff2C2E5E),
//                  ),
//                ),
//              ),
//            ),
          ],
        ),
        bottom: PreferredSize(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color(0xff2C2E5E).withOpacity(0.26)))),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (!mounted) return;
                        setState(() {
                          thisWeek = true;
                        });
                      },
                      child: Center(
                          child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: thisWeek
                                        ? Color(0xff2C2E5E)
                                        : Colors.transparent,
                                    width: 2))),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text('Текущая Неделя',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: thisWeek
                                    ? Color(0xff2C2E5E)
                                    : Color(0xff2C2E5E).withOpacity(0.26),
                              )),
                        ),
                      )),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (!mounted) return;
                        setState(() {
                          thisWeek = false;
                        });
                      },
                      child: Center(
                          child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: thisWeek
                                        ? Colors.transparent
                                        : Color(0xff2C2E5E),
                                    width: 2))),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text('Следующая Неделя',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: !thisWeek
                                    ? Color(0xff2C2E5E)
                                    : Color(0xff2C2E5E).withOpacity(0.26),
                              )),
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(30.h),
        ),
      ),
      body: _hasData
          ? Dismissible(
              resizeDuration: null,
              // ignore: missing_return
              confirmDismiss: (direction) {
                if (!mounted) return;
                setState(() {
                  thisWeek =
                      direction == DismissDirection.endToStart ? false : true;
                  globalIndex = -1;
                });
              },
              key: ValueKey(thisWeek),
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Wrap(
                        children: widgetBuilder(dates),
                      ),
                    ],
                  ),
                  loading
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: GestureDetector(
                              onTap: () => print('smth'),
                              child: Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xff4A62AA))))))
                      : Container()
                ],
              ))
          : Center(
              child: Text(
              "Список пуст".toUpperCase(),
              style: TextStyle(
                  color: Color(0xff2C2E5E),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            )),
    );
  }
}

//@override
//  Widget build(BuildContext context) {
//    Map map = ModalRoute.of(context).settings.arguments;
////    setState(() {
////      _id = map['id'];
////    });
////    if (futureDatesList == null)
////      futureDatesList = fetchDates(context, map['id']);
////    else
////      fetchDates(context, _id);
//    setState(() {});
//    ScreenUtil.init(context,
//        designSize: Size(360, 706), allowFontScaling: false);
//    return Scaffold(
//      backgroundColor: Colors.white,
//      appBar: AppBar(
//        elevation: 0,
//        automaticallyImplyLeading: false,
//        backgroundColor: Colors.white,
//        toolbarHeight: 130.h,
//        title: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: [
//            GestureDetector(
//              onTap: () {
//                Navigator.pop(context);
//              },
//              child: Row(
//                children: [
//                  Icon(
//                    Icons.arrow_back_ios_rounded,
//                    size: 20.w,
//                    color: Color(0xff2C2E5E),
//                  ),
//                  Text(
//                    'Школы',
//                    style: TextStyle(
//                      fontSize: 14.sp,
//                      fontWeight: FontWeight.w400,
//                      color: Color(0xff2C2E5E),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            SizedBox(height: 18.h),
//            Center(
//              child: Text(
//                'Дни Недели',
//                style: TextStyle(
//                  fontSize: 28.sp,
//                  fontWeight: FontWeight.w700,
//                  color: Color(0xff2C2E5E),
//                ),
//              ),
//            ),
//          ],
//        ),
//        bottom: PreferredSize(
//          child: Padding(
//            padding: EdgeInsets.symmetric(horizontal: 16.w),
//            child: Container(
//              decoration: BoxDecoration(
//                  border: Border(
//                      bottom: BorderSide(
//                          color: Color(0xff2C2E5E).withOpacity(0.26)))),
//              child: Row(
//                children: [
//                  Expanded(
//                    child: InkWell(
//                      onTap: () {
//                        print('Текущая Неделя');
//                        setState(() {
//                          thisWeek = true;
//                        });
//                      },
//                      child: Center(
//                          child: Container(
//                        decoration: BoxDecoration(
//                            border: Border(
//                                bottom: BorderSide(
//                                    color: thisWeek
//                                        ? Color(0xff2C2E5E)
//                                        : Colors.transparent,
//                                    width: 2))),
//                        child: FittedBox(
//                          fit: BoxFit.fitWidth,
//                          child: Text('Текущая Неделя',
//                              style: TextStyle(
//                                fontSize: 16.sp,
//                                fontWeight: FontWeight.w700,
//                                color: thisWeek
//                                    ? Color(0xff2C2E5E)
//                                    : Color(0xff2C2E5E).withOpacity(0.26),
//                              )),
//                        ),
//                      )),
//                    ),
//                  ),
//                  Expanded(
//                    child: InkWell(
//                      onTap: () {
//                        print('Следующая Неделя');
//                        setState(() {
//                          thisWeek = false;
//                        });
//                      },
//                      child: Center(
//                          child: Container(
//                        decoration: BoxDecoration(
//                            border: Border(
//                                bottom: BorderSide(
//                                    color: thisWeek
//                                        ? Colors.transparent
//                                        : Color(0xff2C2E5E),
//                                    width: 2))),
//                        child: FittedBox(
//                          fit: BoxFit.fitWidth,
//                          child: Text('Следующая Неделя',
//                              style: TextStyle(
//                                fontSize: 16.sp,
//                                fontWeight: FontWeight.w700,
//                                color: !thisWeek
//                                    ? Color(0xff2C2E5E)
//                                    : Color(0xff2C2E5E).withOpacity(0.26),
//                              )),
//                        ),
//                      )),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//          preferredSize: Size.fromHeight(30.h),
//        ),
//      ),
//      body: Dismissible(
//        resizeDuration: null,
//        // ignore: missing_return
//        confirmDismiss: (direction) {
//          setState(() {
//            thisWeek = direction == DismissDirection.endToStart ? false : true;
//            globalIndex = -1;
//          });
//        },
////        onDismissed: (DismissDirection direction) {
////          setState(() {
////            thisWeek = direction == DismissDirection.endToStart ? false : true;
////            globalIndex = -1;
////          });
////        },
//        key: ValueKey(thisWeek),
//        child: FutureBuilder<List<Date>>(
//          future: futureDatesList,
//          builder: futureBuilder,
//        ),
//      ),
//    );
//  }

// this is listview.builder
//ListView.builder(
//          // ignore: missing_return
//          itemBuilder: (context, index) {
//            bool even = false;
//            bool last = false;
//            if (dates.length % 2 == 0) {
//              even = true;
//              globalIndex += 2;
//            } else {
//              even = false;
//              if (globalIndex + 2 == dates.length) {
//                globalIndex++;
//                last = true;
//              } else {
//                last = false;
//                globalIndex += 2;
//              }
//            }
//
//            index = globalIndex;
//            if (even && globalIndex < dates.length) {
//              return Row(
//                children: [
//                  WeekdayCard(
//                    id: dates[index - 1].id,
//                    name: dates[index - 1].name,
//                    week: dates[index - 1].week,
//                    date: dates[index - 1].date,
//                    today: dates[index - 1].today,
//                  ),
//                  WeekdayCard(
//                    id: dates[index].id,
//                    name: dates[index].name,
//                    week: dates[index].week,
//                    date: dates[index].date,
//                    today: dates[index].today,
//                  ),
//                ],
//              );
//            } else {
//              if (last) {
//                return Row(
//                  children: [
//                    WeekdayCard(
//                      id: dates[index].id,
//                      name: dates[index].name,
//                      week: dates[index].week,
//                      date: dates[index].date,
//                      today: dates[index].today,
//                    ),
//                  ],
//                );
//              } else if (!last && globalIndex < dates.length) {
//                return Row(
//                  children: [
//                    WeekdayCard(
//                      id: dates[index - 1].id,
//                      name: dates[index - 1].name,
//                      week: dates[index - 1].week,
//                      date: dates[index - 1].date,
//                      today: dates[index - 1].today,
//                    ),
//                    WeekdayCard(
//                      id: dates[index].id,
//                      name: dates[index].name,
//                      week: dates[index].week,
//                      date: dates[index].date,
//                      today: dates[index].today,
//                    ),
//                  ],
//                );
//              }
//            }
//          },
//          itemCount: dates.length,
//        ),
