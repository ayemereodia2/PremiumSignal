import 'package:flutter/material.dart';
import 'package:zenithbankkyc/presentation/screens/login_screen.dart';
import 'package:zenithbankkyc/presentation/utilities/custom_Colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("KYC"),
      backgroundColor: ZenithColor.primaryColor,
      elevation: 0.0,
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                exitApp(context);
              },
              child: Icon(Icons.exit_to_app),
            )),
      ],
    );
  }

  void exitApp(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation secondaryAnimation) {
          return LoginScreen();
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }),
        (Route route) => false);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
