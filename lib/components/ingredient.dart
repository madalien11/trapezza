import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

class Ingredients extends StatelessWidget {
  final String name;
  Ingredients({this.name = 'Ingredient'});
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      child: Container(
        height: 30.h,
        decoration: BoxDecoration(
            color: Color(0xff2C2E5E).withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xff2C2E5E), fontSize: 11.sp),
          ),
        ),
      ),
    );
  }
}
