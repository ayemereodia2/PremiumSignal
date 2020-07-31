import 'package:flutter/material.dart';
import 'package:zenithbankkyc/presentation/screens/login_screen.dart';
import 'package:zenithbankkyc/presentation/screens/menu_screen.dart';
import 'core/util/constants.dart';
import 'injection_container.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        LOGIN_PATH:(context) => LoginScreen(),
        SHOW_LIST_PATH:(context) => MenuPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
