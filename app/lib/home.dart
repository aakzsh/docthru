import 'package:docthru/encrypt.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Codec<String, String> stringToBase64 = utf8.fuse(base64);
String name = "name", place = "Noida", profession = "profession";

class _HomeState extends State<Home> {
  void x() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      {
        if (value.exists) {
          setState(() {
            name = "${stringToBase64.decode((value.data()["name"]))}";
            place = "${stringToBase64.decode((value.data()["place"]))}";
            profession =
                "${stringToBase64.decode((value.data()["profession"]))}";
          });
          // print('Document data: ${(value.data()["name"])}');
        } else {
          print('Document does not exist on the database');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    x();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30),
              child: Container(
                height: 100,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Hey $name",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "how are you doing today?",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {},
                  height: 150,
                  minWidth: 150,
                  color: Colors.purple[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.medical_services,
                        size: 60,
                        color: Colors.white,
                      ),
                      Text(
                        "Patients",
                        style: commonstyle(),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(
                          Icons.location_city,
                          size: 60,
                          color: Colors.white,
                        ),
                        // Text(
                        //   "${stringToBase64.decode(place).toString()}",
                        //   style: commonstyle(),
                        // ),
                        Text(
                          "$place",
                          style: commonstyle(),
                        ),
                      ],
                    ),
                    onPressed: () {},
                    height: 150,
                    minWidth: 150,
                    color: Colors.green[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MaterialButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(
                          Icons.mobile_friendly,
                          size: 60,
                          color: Colors.white,
                        ),
                        Text(
                          "Instructions",
                          style: commonstyle(),
                        ),
                      ],
                    ),
                    onPressed: () {},
                    height: 150,
                    minWidth: 150,
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                        side: BorderSide(color: Colors.red)),
                  ),
                  MaterialButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.logout,
                            size: 60,
                            color: Colors.white,
                          ),
                          Text(
                            "LogOut",
                            style: commonstyle(),
                          ),
                        ],
                      ),
                      onPressed: () {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        auth.signOut().then((res) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                              (Route<dynamic> route) => false);
                        });
                      },
                      height: 150,
                      minWidth: 150,
                      color: Colors.blueAccent[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

cont(text, url) {
  return Container(
    child: Column(
      children: <Widget>[
        Text("$text"),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              url,
              size: 50,
            ),
          ],
        )
      ],
    ),
  );
}

commonstyle() {
  return TextStyle(
      color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold);
}
