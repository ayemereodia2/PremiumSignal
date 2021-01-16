import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:zenithbankkyc/bloc/login_bloc.dart';
import 'package:zenithbankkyc/core/util/constants.dart';
import 'package:zenithbankkyc/presentation/utilities/Utils.dart';
import 'package:zenithbankkyc/presentation/utilities/toast_alert.dart';

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width*0.8;

    return MaterialApp(

      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/signap.png"), fit: BoxFit.cover)
        ),

        child: new Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.transparent,
            body: BlocProvider(
              create: (context) {
                return LoginBloc();
              },
              child: BlocBuilder<LoginBloc, OnValidationSuccess>(
                buildWhen: (previous, current) =>
                    previous.username != current.username,
                builder: (context, state) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //   SizedBox(height: 40.0),
                        buildZenithLogo(c_width),
                        Container(
                          padding:
                              EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                          child: Column(
                            children: <Widget>[
                              userNameTextField(context, state),
                              SizedBox(height: 20.0),
                              passwordTextField(context, state),
                              SizedBox(height: 50.0),
                              RaisedGradientButton(
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                  ),
                                  gradient: LinearGradient(
                                    colors: <Color>[Colors.lightBlueAccent, Colors.blue],
                                  ),
                                  onPressed: (){
                                    print('button clicked');
                                  }
                              ),
                              SizedBox(height: 10.0),
                              _RegisterButton(),
                              SizedBox(height: 20.0),
                              RaisedButton(child: Text(
                                'New user? Register',
                                style: TextStyle(color: Colors.purpleAccent,fontWeight: FontWeight.bold),
                              ),
                                gradient: LinearGradient(
                                  colors: <Color>[Colors.white, Colors.white],
                                ),
                                onPressed: (){
                                  print('button clicked');
                              }
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.0),
                      ],
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }

  TextField passwordTextField(BuildContext context, OnValidationSuccess state) {
    return TextField(
        maxLength: 10,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            errorText: state.password.invalid ? 'invalid password' : null,
            counterText: '',
            labelText: 'Password',
            labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.lightBlueAccent),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red))),
        obscureText: true,
        onChanged: (password) =>
            context.bloc<LoginBloc>().add(PasswordChanged(password)));
  }

  TextField userNameTextField(BuildContext context, OnValidationSuccess state) {
    return TextField(
      decoration: InputDecoration(
          errorText: state.username.invalid ? 'invalid username' : null,
          labelText: 'Username',
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.lightBlueAccent),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red))),
      onChanged: (username) =>
          context.bloc<LoginBloc>().add(UsernameChanged(username)),
    );
  }
  Container buildZenithLogo(double width) {

    return Container(
      padding: const EdgeInsets.fromLTRB(5,30,100,100),
      width: width,
      child: new Column (
        children: <Widget>[
          new Text ("PREMIUM", textAlign: TextAlign.left,style: TextStyle(color: Colors.lightBlueAccent,fontSize: 30.0, fontWeight: FontWeight.bold ),),
          new Text ("SIGNALS..", textAlign: TextAlign.left,style: TextStyle(color: Colors.lightBlueAccent,fontSize: 30.0,fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void submit(BuildContext context) {
    ToastUtils.showCustomToast(context, "Logged in");
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, OnValidationSuccess>(
      listener: (context, state) {
        if (state is LogInSuccessState) {
          Navigator.pushReplacementNamed(context, SHOW_LIST_PATH);
        }
        if (state is ErrorState) {
          showErrorMessage(context, state.errorMessage);
          //   Navigator.pushReplacementNamed(context, SHOW_LIST_PATH);
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ButtonTheme(
                height: 45.0,
                minWidth: 200.0,
                child: FlatButton(
                  color: Colors.lightBlueAccent,
                  disabledColor: Colors.grey,
                  key: const Key('loginForm_continue_raisedButton'),
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  onPressed: state.status.isValidated
                      ? () {
                          context.bloc<LoginBloc>().add(LoginButtonSubmitted(
                              state.username.value, state.password.value));
                        }
                      : null,
                ),
              );
      },
    );
  }
}


class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, OnValidationSuccess>(
      listener: (context, state) {
        if (state is LogInSuccessState) {
          Navigator.pushReplacementNamed(context, SHOW_LIST_PATH);
        }
        if (state is ErrorState) {
          showErrorMessage(context, state.errorMessage);
          //   Navigator.pushReplacementNamed(context, SHOW_LIST_PATH);
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ButtonTheme(
          height: 25.0,
          minWidth: 200.0,
          child: FlatButton(
            color: Colors.white,
            key: const Key('loginForm_continue_raisedButton'),
            child: Center(
              child: Text(
                'Forgot Password?.',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
            ),
            onPressed: state.status.isValidated
                ? () {}
                : null,
          ),
        );
      },
    );
  }
}


class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(gradient: gradient, boxShadow: [
        BoxShadow(
          color: Colors.grey[500],
          offset: Offset(0.0, 1.5),
          blurRadius: 1.5,
        ),
      ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}


class RaisedButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 20.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(gradient: gradient, boxShadow: [
        BoxShadow(
          color: Colors.grey[500],
          offset: Offset(0.0, 1.5),
          blurRadius: 1.5,
        ),
      ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
