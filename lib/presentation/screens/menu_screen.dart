import 'package:flutter/material.dart';
import 'package:zenithbankkyc/presentation/screens/geolocattion_screen.dart';
import 'package:zenithbankkyc/presentation/screens/login_screen.dart';

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
          body: unverifiedAccounts(context)),
    );
  }
}

Widget unverifiedAccounts(BuildContext context) {
  List<Accountverification> unverifiedAccount = [
    Accountverification('1020209781', '8th tuoyo street banassssss.'),
    Accountverification('1020888888', 'cresten drive'),
    Accountverification('8928929228', 'apple estate amowu-dofin'),
    Accountverification('2789282299', 'main land hub downtown'),
    Accountverification('5263533536', 'opebi road off aja'),
    Accountverification('7871888118', ' 10 london niegeria str'),
    Accountverification('2728728728', 'illupeju canada road'),
    Accountverification(
        '1819818119', ' 2nd china town ikeja lagos000000000000000000000'),
  ];
  return ListView.builder(
    itemCount: unverifiedAccount.length,
    itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          onTap: () {
            print('helloList');
            //  print(unverifiedAccount[index].userAccount);
          }, //uhu
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Acct N0: ${unverifiedAccount[index].userAccount}"),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Addr: ${unverifiedAccount[index].userAddress}",
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
                borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                onPressed: () {
                  String val = unverifiedAccount[index].userAddress.toString();
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
class Accountverification {
  String userAccount;
  String userAddress;

  Accountverification(this.userAccount, this.userAddress);
}
