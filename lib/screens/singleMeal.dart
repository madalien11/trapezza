import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trapezza/classes/Ingredient.dart';
import 'dart:ui';
import 'package:trapezza/components/ingredient.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'fullImageScreen.dart';

List<Ingredient> ingredientsInScreen = [];

class SingleMealScreen extends StatefulWidget {
  static const String id = 'single_meal_screen';
  final String title;
  final int price;
  final List<String> ingredients;
  final List<String> certificates;
  final String description;
  final String imageUrl;
  SingleMealScreen(
      {this.title = 'Суп Томям',
      this.price = 1000,
      this.ingredients = const [
        'Свежие огурцы',
        'Болгарский перец',
        'Сыр пармезан',
        'Перец чили',
        'Приправы',
        'Тофу',
        'Мидии',
        'Помидор',
        'Креветки',
      ],
      this.certificates = const [
        "https://picsum.photos/300/200",
        "https://picsum.photos/300/200",
        "https://picsum.photos/300/200",
        "https://picsum.photos/300/200",
        "https://picsum.photos/300/200",
        "https://picsum.photos/300/200",
      ],
      this.description =
          'Корейский суп с морепродруктами придется по вкусу любителям корейской кухни и ценителям острой еды корейский суп с морепродруктами придется по вкусу любителям корейской кухни и ценителям острой еды',
      this.imageUrl = "https://picsum.photos/300/200"});
  @override
  _SingleMealScreenState createState() => _SingleMealScreenState();
}

class _SingleMealScreenState extends State<SingleMealScreen> {
  List<String> listOfCertificates = [];
  bool getCertificatesCalled = false;
  void getCertificates() {
    for (int i = 0; i < ingredientsInScreen.length; i++) {
      var x = ingredientsInScreen[i].images;
      for (int j = 0; j < x.length; j++) {
        listOfCertificates
            .add('http://api.trapezza.kz/' + x[j]['path'].toString());
      }
    }
//    int index = 0;
//    for (Ingredient i in ingredientsInScreen) {
//      listOfCertificates
//          .add('http://api.trapezza.kz/' + i.images[index]['path'].toString());
//      index++;
//    }
  }

  @override
  void dispose() {
    super.dispose();
    if (ingredientsInScreen != null) ingredientsInScreen.clear();
    if (listOfCertificates != null) listOfCertificates.clear();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    Map map = ModalRoute.of(context).settings.arguments;
    String mapImageUrl;
    String mapTitle;
    String mapPrice;
    String mapDescription;
    if (map != null) {
      if (map['ingredients'] != null)
        ingredientsInScreen = map['ingredients'];
      else
        ingredientsInScreen = [];
      if (map['imageUrl'] != null)
        mapImageUrl = map['imageUrl'];
      else
        mapImageUrl = '';
      if (map['title'] != null)
        mapTitle = map['title'];
      else
        mapTitle = '';
      if (map['price'] != null)
        mapPrice = map['price'].toString();
      else
        mapPrice = '';
      if (map['description'] != null)
        mapDescription = map['description'];
      else
        mapDescription = '';
    }
    if (!getCertificatesCalled) {
      getCertificates();
      getCertificatesCalled = true;
    }
    return Scaffold(
      backgroundColor: Color(0xffFDFDFD),
      body: ListView(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return FullImageScreen(image: NetworkImage(mapImageUrl));
                  }));
                },
                child: Container(
                    height: 275.h,
                    width: double.infinity,
                    child: Image.network(
                      mapImageUrl,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xff4A62AA))));
                      },
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 30.h, left: 12.w),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: 10.w, top: 1.h, bottom: 1.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 20.w,
                            color: Colors.white,
                          ),
                          Text(
                            'Блюда',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Row(
              children: [
                Flexible(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      mapTitle,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff2C2E5E)),
                    ),
                  ),
                ),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        mapPrice.toString() + 'тг',
                        style: TextStyle(
                            fontSize: 26.sp,
                            color: Color(0xffBD1C06),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Wrap(
              children: [
                for (Ingredient i in ingredientsInScreen)
                  Ingredients(name: i.name)
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Text(
                mapDescription.toString(),
                style: TextStyle(color: Color(0xff2C2E5E), fontSize: 15.sp),
              )),
          listOfCertificates.length > 0
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 200.h,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
//              onPageChanged: callbackFunction,
                      scrollDirection: Axis.horizontal,
                    ),
                    itemCount: listOfCertificates.length,
                    itemBuilder: (BuildContext context, int itemIndex) =>
                        Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return FullImageScreen(
                                    image: NetworkImage(
                                        listOfCertificates[itemIndex]));
                              }));
                            },
                            child: Center(
                              child: Image.network(
                                listOfCertificates[itemIndex],
                                fit: BoxFit.fitWidth,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                      child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Color(0xff4A62AA))));
                                },
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.35),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 10.w,
                                          top: 1.h,
                                          bottom: 1.h,
                                          left: 10.w),
                                      child: Text(
                                        'Certificate №' +
                                            (itemIndex + 1).toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  )))
                        ],
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
