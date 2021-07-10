import 'package:docthru/newpatient.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Patients extends StatefulWidget {
  @override
  _PatientsState createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  List<String> array;
  getpatients() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      {
        if (value.exists) {
          setState(() {
            array = (value.data()["patients"]);
          });
          // print('Document data: ${(value.data()["name"])}');
        } else {
          print('Document does not exist on the database');
        }
      }
    });
    getpatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NewPatient()));
          },
        ),
        body: Container(
            child: Container(
                height: 400,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: array.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        child: Center(child: Text('${array[index]}')),
                      );
                    }))));
  }
}

final auth = FirebaseAuth.instance;
final firestoreInstance = FirebaseFirestore.instance;
