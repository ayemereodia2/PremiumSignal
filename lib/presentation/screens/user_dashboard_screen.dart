import 'package:flutter/material.dart';
import 'package:zenithbankkyc/presentation/screens/account_detail_screen.dart';
import 'package:zenithbankkyc/presentation/screens/geolocattion_screen.dart';
import 'package:zenithbankkyc/presentation/screens/widgets/custom_appBar.dart';
import 'package:zenithbankkyc/presentation/utilities/custom_Colors.dart';

class DashoardScreen extends StatefulWidget {
  @override
  _DashoardScreenState createState() => _DashoardScreenState();
}

class _DashoardScreenState extends State<DashoardScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(screenHeight),
          _buildClaimedAccountList(screenHeight)
        ],
      ),
    );
  }
}

SliverToBoxAdapter _buildHeader(double screenHeight) {
  return SliverToBoxAdapter(
    child: Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [0.6, 0.3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ZenithColor.primaryAccentColor, ZenithColor.primaryColor],
        ),
        color: ZenithColor.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: screenHeight * 0.003),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Good Afternoon, Michael0000', //rsm name first name
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'You have 3 accounts awaiting your verification', //claimed account list
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
            ],
          )
        ],
      ),
    ),
  );
}

SliverToBoxAdapter _buildClaimedAccountList(double screenHeight) {
  List<ClaimedAccount> accounts = [
    new ClaimedAccount('1', '1010010101', 'user1', 'of lagos', '0903'),
    new ClaimedAccount('2', '1010010101', 'user2', 'somewhere', '0903'),
    new ClaimedAccount('3', '626226272', 'user3', 'eeieie', '0903'),
  ];
  return SliverToBoxAdapter(
    child: Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Claimed Accounts',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            height: screenHeight,
            child: new ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      print('helloList');
                      detailView(context, accounts[index]);
                    },
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Acct No: ${accounts[index].accountName}"),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Address: ${accounts[index].residentialAddress}",
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
                            String val =
                                accounts[index].residentialAddress.toString();
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
            ),
          )
        ],
      ),
    ),
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

void detailView(BuildContext context, ClaimedAccount user) {
  Navigator.push(
      context,
      PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return CustomerDetail(
          customer: user,
        );
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

class ClaimedAccount {
  final String id;
  final String accountNumber;
  final String accountName;
  final String residentialAddress;
  final String phoneNumber;

  ClaimedAccount(this.id, this.accountNumber, this.accountName,
      this.residentialAddress, this.phoneNumber);
}
