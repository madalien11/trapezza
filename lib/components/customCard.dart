import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trapezza/classes/Ingredient.dart';
import 'package:trapezza/classes/meal.dart';
import 'package:trapezza/data/data.dart';
import 'dart:ui';
import 'package:trapezza/screens/meals.dart';
import 'package:trapezza/screens/singleMeal.dart';

List<int> listOfColors = [
  0xffF2BD00,
  0xff44A5B8,
  0xffF2943A,
  0xffC061E1,
  0xff45CD08,
];

class CustomCard extends StatefulWidget {
  final int id;
  final bool isTable;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final int price;
  final int tableNum;
  final bool isCertified;
  final int num;
  final Function callBack;
  CustomCard({
    @required this.id,
    @required this.isTable,
    @required this.title,
    this.subtitle,
    @required this.description,
    this.price = 1000,
    this.tableNum = 1,
    @required this.imageUrl,
    this.isCertified = false,
    @required this.num,
    this.callBack,
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool _isDisabled;
  List<Meal> _meals = [];
  List<Ingredient> _ingredients = [];

  Future getMeals(id) async {
    var response = await MealGetter(id: id).getData();
    if (response != null) {
      List _mealsList = response['data'];
      if (!mounted) return;
      setState(() {
        for (var meal in _mealsList) {
          Meal s = Meal(
            id: meal['id'],
            name: meal['name'],
            description: meal['description'],
            imageUrl: meal['img'],
            price: meal['price'],
            hasCertificate: meal['certificate'],
          );
          _meals.add(s);
        }
      });
    }
  }

  Future getIngredients(id) async {
    var response = await IngredientsGetter(id: id).getData();
    if (response != null) {
      List _ingredientsList = response['data']['ingredient'];
      List _certificatesList = response['data']['certificate'];
      if (!mounted) return;
      setState(() {
        for (var ingredient in _ingredientsList) {
          Ingredient s = Ingredient(
            id: ingredient['id'],
            name: ingredient['name'],
            images: _certificatesList,
          );
          _ingredients.add(s);
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
  void dispose() {
    super.dispose();
    if (_meals != null) _meals.clear();
    if (_ingredients != null) _ingredients.clear();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    String img = "http://api.trapezza.kz/" + widget.imageUrl.toString();
//    double height = MediaQuery.of(context).size.height; // 706
//    double width = MediaQuery.of(context).size.width; // 360
    return InkWell(
      onTap: _isDisabled
          ? () => print('')
          : widget.isTable
              ? () async {
                  if (!mounted) return;
                  setState(() {
                    _isDisabled = true;
                  });
                  await getMeals(widget.id);
                  Navigator.pushNamed(context, MealsScreen.id, arguments: {
                    'tableNum': widget.tableNum,
                    'meals': _meals,
                  });
                  if (!mounted) return;
                  setState(() {
                    _isDisabled = false;
                  });
                }
              : () async {
                  if (!mounted) return;
                  setState(() {
                    _isDisabled = true;
                  });
                  widget.callBack();
                  await getIngredients(widget.id);
                  Navigator.pushNamed(context, SingleMealScreen.id, arguments: {
                    'price': widget.price,
                    'ingredients': _ingredients,
                    'description': widget.description,
                    'id': widget.id,
                    'title': widget.title,
                    'isCertified': widget.isCertified,
                    'imageUrl':
                        "http://api.trapezza.kz/" + widget.imageUrl.toString(),
                  });
                  widget.callBack();
                  if (!mounted) return;
                  setState(() {
                    _isDisabled = false;
                  });
                },
      child: Container(
        height: widget.isTable ? 160.h : 120.h,
        margin: EdgeInsets.all(8.w),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: widget.isTable ? 7 : 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  child:
//                  image("https://picsum.photos/200/300"),
//                    CachedNetworkImage(
//                      imageUrl: "https://picsum.photos/200/300",
//                      fit: BoxFit.fill,
//                      progressIndicatorBuilder:
//                          (context, url, downloadProgress) => Container(
//                              child: CircularProgressIndicator(
//                                  value: downloadProgress.progress),
//                              padding: EdgeInsets.symmetric(
//                                  vertical: 5.h, horizontal: 60.w)),
//                      errorWidget: (context, url, error) => Image.asset(
//                          'images/imageError.jpg',
//                          fit: BoxFit.fill),
//                    )
                      Image.network(
                    img,
                    fit: BoxFit.fitHeight,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xff4A62AA))));
                    },
                  ),
                ),
              ),
              Expanded(
                flex: widget.isTable ? 8 : 5,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.isTable ? 12.w : 9.w, vertical: 8.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: widget.isTable ? 3 : 1,
                        child: widget.isTable
                            ? FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Column(
                                  children: [
                                    Text(
                                      widget.title.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff000000)
                                              .withOpacity(0.85)),
                                    ),
                                    SizedBox(height: 1),
                                    Text(
                                      widget.subtitle.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp,
                                          color: Color(0xff000000)
                                              .withOpacity(0.85)),
                                    )
                                  ],
                                ),
                              )
                            : FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  widget.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          Color(0xff000000).withOpacity(0.85)),
                                ),
                              ),
                      ),
                      Expanded(
                        flex: widget.isTable ? 5 : 3,
                        child: Center(
                          child: Text(
                            widget.description,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: widget.isTable
                                    ? Color(0xff2C2E5E).withOpacity(0.67)
                                    : Color(0xff000000).withOpacity(0.6),
                                fontSize: 10.sp),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: widget.isTable ? 2 : 1,
                        child: widget.isTable
                            ? Padding(
                                padding: EdgeInsets.only(top: 3.h),
                                child: FlatButton(
                                    onPressed: _isDisabled
                                        ? () => print('')
                                        : () async {
                                            if (!mounted) return;
                                            setState(() {
                                              _isDisabled = true;
                                            });
                                            await getMeals(widget.id);
                                            Navigator.pushNamed(
                                                context, MealsScreen.id,
                                                arguments: {
                                                  'tableNum': widget.tableNum,
                                                  'meals': _meals,
                                                });
                                            if (!mounted) return;
                                            setState(() {
                                              _isDisabled = false;
                                            });
                                          },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    color: Color(listOfColors[
                                        this.widget.num % listOfColors.length]),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      child: Text(
                                        'Подробнее',
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 2),
                                      ),
                                    )),
                              )
                            : FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.price.toString() + 'тг',
                                      style: TextStyle(
                                          fontSize: 28.sp,
                                          color: Color(0xffBD1C06),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 80),
                                    widget.isCertified
                                        ? Row(
                                            children: [
                                              Icon(Icons.bookmark,
                                                  size: 16.sp,
                                                  color: Color(0xffCF1928)),
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                  'Товар сертифицирован',
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.4)),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
