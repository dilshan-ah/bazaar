import 'package:bazaar/screen/dashboard/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController ? _username;
  TextEditingController ? _phonenumber;

  setdatatoTextfeild(data){
    return Column(
      children: [
        CircleAvatar(
          radius: 64,
          backgroundColor: Theme.of(context).primaryColor,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.camera_alt,color: Theme.of(context).primaryColor,size: 40,),
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (context)=>AlertDialog(
                      title: Text("Choose your photo"),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: (){}, child: Text("Camera",style: TextStyle(color: Colors.red),)),
                          TextButton(onPressed: (){}, child: Text("Gallery",style: TextStyle(color: Colors.green),)),
                        ],
                      ),
                    )
                );
              },
            ),
          ),
        ),
        SizedBox(height: 20,),
        TextField(
          controller: _username=TextEditingController(text: data["name"]),
          decoration: InputDecoration(
              hintText: _username!.text,
              labelText: "Name",
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: Colors.orange
                  )
              )
          ),
        ),
        SizedBox(height: 20,),
        TextField(
          controller: _phonenumber=TextEditingController(text: data["phone"]),
          decoration: InputDecoration(
              hintText: _phonenumber!.text,
              labelText: "Phone number",
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: Colors.orange
                  )
              )
          ),
        ),
        SizedBox(height: 20,),
        FlatButton(
            color: Theme.of(context).primaryColor,
            onPressed: (){
              updatedata();
            },
            child: Text("Update",style: TextStyle(
                color: Colors.white
            ),)
        )
      ],
    );
  }

  updatedata(){
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({"name": _username!.text, "phone": _phonenumber!.text})
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("something is wrong. $error"));
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Update Profile"),
      content: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var data = snapshot.data;
            if(data==null){
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
            return setdatatoTextfeild(data);
          },
        ),
      ),
    );
  }
}
