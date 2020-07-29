import 'package:flutter/material.dart';
import 'package:zenithbankkyc/presentation/utilities/toast_alert.dart';

class LoginScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: new Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //   SizedBox(height: 40.0),
                Container(
                  width: 100.00,
                  height: 100.00,
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: ExactAssetImage('assets/zenithLogo.png'),
                          fit: BoxFit.fitHeight)),
                ),
                Container(
                    padding:
                        EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red))),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              counterText: '',
                              labelText: 'Pin+OTP',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red))),
                          obscureText: true,
                        ),
                        SizedBox(height: 50.0),
                        GestureDetector(
                          onTap: () => submit(),
                          child: Container(
                            height: 45.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(5.0),
                              shadowColor: Colors.redAccent,
                              color: Colors.red,
                              elevation: 7.0,
                              child: GestureDetector(
                                child: Center(
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    )),
                SizedBox(height: 15.0),
              ],
            ),
          )),
    );
  }

  void submit() {
    ToastUtils.showCustomToast(context, "Logged in");
  }
}
