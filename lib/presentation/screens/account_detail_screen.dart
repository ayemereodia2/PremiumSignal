import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zenithbankkyc/presentation/screens/user_dashboard_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:zenithbankkyc/presentation/utilities/custom_Colors.dart';

class CustomerDetail extends StatefulWidget {
  final ClaimedAccount customer;
  const CustomerDetail({@required this.customer});

  @override
  _CustomerDetailState createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  Future _openCamera(BuildContext context) async {
    var profilePicture =
        imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = profilePicture;
    });
  }

  _openGellery(BuildContext context) async {
    var profilePicture =
        imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = profilePicture;
    });
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 150,
              child: Column(children: <Widget>[
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _openCamera(context);
                    },
                    leading: Icon(
                      Icons.photo_camera,
                      color: ZenithColor.primaryAccentColor,
                    ),
                    title: Text("Take a picture from camera")),
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _openGellery(context);
                    },
                    leading: Icon(Icons.photo_library,
                        color: ZenithColor.primaryAccentColor),
                    title: Text("Choose from photo library"))
              ]));
        });
  }

  File imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Detail screen'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                  onDoubleTap: () {
                    print("clikced");
                    _showOptions(context);
                  },
                  child: imageFile == null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(children: <Widget>[
                              Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height / 2.05,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "assets/placeholder1.png",
                                        ),
                                        fit: BoxFit.cover)),
                              ),
                              Text(
                                "Double Tap here to open Camera or gallery.",
                                style: TextStyle(color: Colors.grey),
                              )
                            ]),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 2.05,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                      // image: FileImage()
                                      image: FileImage(imageFile),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                Stack(children: <Widget>[
                  Column(
                    children: <Widget>[
                      new Card(
                        child: new Container(
                          width: double.infinity,
                          padding: new EdgeInsets.all(8.0),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text("Account Name: "),
                                    Expanded(
                                      child: Text(
                                        widget.customer.accountName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text("Account Number: "),
                                    Expanded(
                                      child: Text(
                                        widget.customer.accountNumber,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text("Account Address: "),
                                    Expanded(
                                      child: Text(
                                        widget.customer.residentialAddress,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text("Account Phone number: "),
                                    Expanded(
                                      child: Text(
                                        widget.customer.phoneNumber,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlatButton(
                                    child: Text("Unclaim",
                                        style: TextStyle(color: Colors.red)),
                                    onPressed: () {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    color: Colors.red,
                                    onPressed: () {},
                                    child: Text(
                                      'Verify',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ]),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2,
              right: 0,
              //  left: 0,
              // bottom: 0,
              child: ClipOval(
                child: Icon(
                  Icons.check_circle,
                  color: imageFile == null ? Colors.grey : Colors.green,
                  size: 45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
