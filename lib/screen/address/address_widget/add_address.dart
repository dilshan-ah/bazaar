import 'package:bazaar/screen/dashboard/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController _addressname = TextEditingController();
  TextEditingController _location = TextEditingController();

  sendUserslocationDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-location");
    return _collectionRef
        .doc(currentUser!.email)
        .set({"label": _addressname.text, "location": _location.text})
        .then((value) => Navigator.pop(
            context))
        .catchError((error) => print("something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Address"),
      content: Container(
        height: 300,
        child: Column(
          children: [
            TextField(
              controller: _addressname,
              decoration: InputDecoration(
                  hintText: "Address name",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.orange))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _location,
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: "Location",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.orange))),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  sendUserslocationDB();
                },
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
