import 'package:flutter/material.dart';
import 'package:zenithbankkyc/presentation/screens/login_screen.dart';
import 'core/util/constants.dart';
import 'injection_container.dart' as di;
import 'presentation/screens/widgets/bottom_navBar.dart';

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
        LOGIN_PATH: (context) => LoginScreen(),
        SHOW_LIST_PATH: (context) => BottomNavScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
