import 'dart:async';
import 'package:trapezza/screens/schools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _pageViewController = new PageController();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, SchoolsScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageViewController,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Color(0xff4B62AA),
                  padding: EdgeInsets.symmetric(horizontal: 85.w),
                  child: Image.asset(
                    "images/logo.png",
                    fit: BoxFit.scaleDown,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
