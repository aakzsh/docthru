import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docthru/patients.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewPatient extends StatefulWidget {
  @override
  _NewPatientState createState() => _NewPatientState();
}

class _NewPatientState extends State<NewPatient> {
  int count = 0;
  String name, care, threshold, note;
  final auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                name = value;
              },
            ),
            MaterialButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .get()
                    .then((value) {
                  {
                    if (value.exists) {
                      setState(() {
                        count = (value.data()["count"]);
                      });
                      // print('Document data: ${(value.data()["name"])}');
                    } else {
                      print('Document does not exist on the database');
                    }
                  }
                }).then((_) => {
                          firestoreInstance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .set({
                            "patients[$count]": name,
                            // "count": count++,
                          }).then((res) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Patients()),
                                (Route<dynamic> route) => false);
                          })
                        });
              },
              child: Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}

// void lol() {
//   firestoreInstance.collection("users").doc(value.user?.uid).set({
//     "name": stringToBase64.encode(name),
//     "email": stringToBase64.encode(email),
//     "place": stringToBase64.encode(place),
//     "profession": stringToBase64.encode(profession)
//   });
// }
