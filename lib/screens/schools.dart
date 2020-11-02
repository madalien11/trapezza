import 'package:flutter/material.dart';
import 'package:trapezza/components/schoolCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:trapezza/data/data.dart';
import 'package:trapezza/classes/school.dart';

class SchoolsScreen extends StatefulWidget {
  static const String id = 'schools_screen';

  @override
  _SchoolsScreenState createState() => _SchoolsScreenState();
}

class _SchoolsScreenState extends State<SchoolsScreen> {
  Future<List<School>> futureSchoolsList;
  bool pressed = false;

  void loader() {
    if (!mounted) return;
    setState(() {
      pressed = !pressed;
    });
  }

  @override
  void initState() {
    super.initState();
    futureSchoolsList = fetchSchools(context);
    pressed = false;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color(0xffFDFDFD),
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xffFDFDFD),
            toolbarHeight: 80.h,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    'Школы',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff2C2E5E),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return true;
            },
            child: FutureBuilder<List<School>>(
              future: futureSchoolsList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return SchoolCard(
                        id: snapshot.data[index].id,
                        title: snapshot.data[index].title,
                        callBack: loader,
                      );
                    },
                    itemCount: snapshot.data.length,
                  );
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "Список школ пуст".toUpperCase(),
                    style: TextStyle(
                        color: Color(0xff2C2E5E),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700),
                  ));
                }
                // By default, show a loading spinner.
                return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xff4A62AA))
//                        backgroundColor: Color(0xff2C2E5E),
                        ));
              },
            ),
          ),
        ),
        pressed
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
    );
  }
}
