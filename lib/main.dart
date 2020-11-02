import 'package:flutter/material.dart';
import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:flutter/services.dart';
import 'screens/schools.dart';
import 'screens/meals.dart';
import 'screens/week.dart';
import 'screens/tables.dart';
import 'screens/welcome.dart';
import 'screens/singleMeal.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return BackGestureWidthTheme(
      backGestureWidth: BackGestureWidth.fraction(1 / 2),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Trapezza',
        routes: {
          MealsScreen.id: (context) => MealsScreen(),
          SchoolsScreen.id: (context) => SchoolsScreen(),
          TablesScreen.id: (context) => TablesScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          WeekScreen.id: (context) => WeekScreen(),
          SingleMealScreen.id: (context) => SingleMealScreen(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS:
                  CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
            },
          ),
        ),
        home: WelcomeScreen(),
//        home: MealsScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameTextController = TextEditingController();
  final _passTextController = TextEditingController();
  String _email;
  String _password;
  bool _hidePass;
  bool _isButtonDisabled;
  bool _isLoading;
  bool _showError;

  showAlertDialog(BuildContext context, String detail) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(detail),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _hidePass = true;
    _isLoading = false;
    _isButtonDisabled = false;
    _showError = false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double num10 = height * 0.0142;
    double num12 = height * 0.0170;
    double num14 = height * 0.0198;
    double wNum15 = width * 0.0412;
    double num15 = height * 0.0212;
    double wNum18 = width * 0.0480;
    double num20 = height * 0.0283;
    double num30 = height * 0.0425;
    double num54 = height * 0.0765;
    double num80 = height * 0.1133;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
//          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color(0xff207bf0),
            Color(0xff7deefb),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(left: num30, top: num15, right: num30),
                  height: height - num54,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(height: num80),
                        Center(
                          child: Text(
                            'Вход',
                            style: TextStyle(
                                fontSize: num30,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffffffff)),
                          ),
                        ),
                        SizedBox(height: num80),
                        Container(
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            controller: _usernameTextController,
                            onChanged: (value) {
                              _email = value;
                              print(_email);
                            },
                            decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(30.0),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: num20, vertical: num10),
                                hintText: 'ЛОГИН',
                                filled: true,
                                errorText: _showError
                                    ? 'wrong email or password'
                                    : null,
                                hintStyle: TextStyle(fontSize: num14),
                                fillColor: Colors.white70),
                          ),
                        ),
                        SizedBox(height: num10),
                        Container(
                          child: TextField(
                            autofocus: false,
                            controller: _passTextController,
                            obscureText: _hidePass,
                            onChanged: (value) {
                              _password = value;
                              print(_password);
                            },
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if (!mounted) return;
                                    setState(() {
                                      _hidePass = !_hidePass;
                                    });
                                  },
                                  icon: _hidePass
                                      ? Icon(
                                          Icons.visibility,
                                          color: Color(0xff828282),
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: Color(0xff828282),
                                        ),
                                ),
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(30.0),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: num20, vertical: num10),
                                hintText: 'ПАРОЛЬ',
                                filled: true,
                                errorText: _showError
                                    ? 'wrong email or password'
                                    : null,
                                hintStyle: TextStyle(fontSize: num14),
                                fillColor: Colors.white70),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Spacer(),
                            Container(
                              child: FlatButton(
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
//                                      Navigator.pushNamed(
//                                          context, ForgotPassword.id);
                                  },
                                  child: Text(
                                    'Forgot your password?',
                                    style: TextStyle(
                                        fontSize: num12,
                                        color: Color(0xFFFFFFFF)),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(height: num20),
                        SizedBox(
                          height: num54,
                          width: double.infinity,
                          child: FlatButton(
                              onPressed: _isButtonDisabled
                                  ? () => print('Sign In')
                                  : () async {
                                      if (!mounted) return;
                                      setState(() {
                                        _isLoading = true;
                                        _isButtonDisabled = true;
                                      });
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                    },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: Color(0xff1f355d),
                              child: Text(
                                'ВОЙТИ',
                                style: TextStyle(
                                    fontSize: wNum18,
                                    color: Colors.white,
                                    letterSpacing: 3),
                              )),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
//                                    Navigator.pushNamed(
//                                        context, RegistrationScreen.id);
                                },
                                child: Text(
                                  'ЗАРЕГИСТРИРОВАТЬСЯ',
                                  style: TextStyle(
                                      fontSize: wNum15,
                                      color: Color(0xff1f355d),
                                      letterSpacing: 3),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xff4A62AA))))
                : Container()
          ],
        )),
      ),
    );
  }
}
