import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:zenithbankkyc/bloc/login_bloc.dart';
import 'package:zenithbankkyc/core/util/constants.dart';
import 'package:zenithbankkyc/presentation/utilities/Utils.dart';
import 'package:zenithbankkyc/presentation/utilities/toast_alert.dart';

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: new Scaffold(
          resizeToAvoidBottomPadding: false,
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
                      buildZenithLogo(),
                      Container(
                        padding:
                            EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            userNameTextField(context, state),
                            SizedBox(height: 20.0),
                            passwordTextField(context, state),
                            SizedBox(height: 50.0),
                            _LoginButton(),
                            SizedBox(height: 20.0),
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
    );
  }

  TextField passwordTextField(BuildContext context, OnValidationSuccess state) {
    return TextField(
        maxLength: 10,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            errorText: state.password.invalid ? 'invalid password' : null,
            counterText: '',
            labelText: 'Pin+OTP',
            labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.grey),
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
              color: Colors.grey),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red))),
      onChanged: (username) =>
          context.bloc<LoginBloc>().add(UsernameChanged(username)),
    );
  }

  Container buildZenithLogo() {
    return Container(
      width: 100.00,
      height: 100.00,
      decoration: new BoxDecoration(
          image: new DecorationImage(
              image: ExactAssetImage('assets/zenithLogo.png'),
              fit: BoxFit.fitHeight)),
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
                  color: Colors.red,
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
                          // context.bloc<LoginBloc>().add(LoginButtonSubmitted(
                          //     state.username.value, state.password.value));
                          Navigator.pushReplacementNamed(
                              context, SHOW_LIST_PATH);
                        }
                      : null,
                ),
              );
      },
    );
  }
}
