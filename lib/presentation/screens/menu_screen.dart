import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenithbankkyc/bloc/unverified_acc_bloc.dart';
import 'package:zenithbankkyc/data/models/unverified_model.dart';
import 'package:zenithbankkyc/domain/entities/unverified_account.dart';
import 'package:zenithbankkyc/presentation/screens/geolocattion_screen.dart';
import 'package:zenithbankkyc/presentation/screens/login_screen.dart';
import 'package:zenithbankkyc/presentation/utilities/animations/spinner_animations.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("KYC"),
          elevation: 1,
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
        ),
        body: BlocProvider(
          child: unverifiedAccounts(context),
          create: (context) {
            return UnverifiedAccBloc();
          },
        ),
      ),
    );
  }
}

Widget unverifiedAccounts(BuildContext context) {
  List<UnverifiedAccount> unverifiedModel = [];
  return BlocConsumer<UnverifiedAccBloc, UnverifiedAccState>(
    builder: (context, state) {
      context.bloc<UnverifiedAccBloc>().add(EmptyEvent());

      if (state is ErrorState) {
        return Center(
          child: Text(
            state.errorMessage,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        );
      }

      if (state is LoadedUnverifiedAccState) {

        return ListView.builder(
          itemCount: state.unverifiedList.data.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  print('helloList');
                  //  print(unverifiedAccount[index].userAccount);
                }, //uhu
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Acct N0: ${state.unverifiedList.data[index].AccountNumber}"),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Addr: ${state.unverifiedList.data[index].ResidentialAddress}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: ButtonTheme(
                  minWidth: 0.0,
                  height: 0.0,
                  child: OutlineButton(
                      padding: const EdgeInsets.all(0),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      disabledBorderColor: Colors.transparent,
                      borderSide:
                      BorderSide(color: Colors.transparent, width: 0.0),
                      onPressed: () {
                        String val = state.unverifiedList.data[index].ResidentialAddress
                            .toString();
                        mapView(context, val);
                      },
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                      )),
                ),
              ),
            );
          },
        );

      } else if (state is ErrorState){
        return Center(
          child: Text(
            state.errorMessage,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        );
      }else{
        return Center(
          child:  CircularProgressIndicator()
        );
      }

    },
    listener: (BuildContext context, UnverifiedAccState state) {},
  );
}

void mapView(BuildContext context, String userAddress) {
  Navigator.push(
      context,
      PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return MapView(customersAddress: userAddress);
      }, transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return new SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      }));
}

void exitApp(BuildContext context) {
  Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return LoginScreen();
      }, transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
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

//for testing
class AccountVerification {
  String userAccount;
  String userAddress;

  AccountVerification(this.userAccount, this.userAddress);
}
