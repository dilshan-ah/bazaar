import 'package:bazaar/screen/profile/profile_widget/update_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  profiledata(data){
    return Column(
      children: [
        CircleAvatar(
          radius: 44,
          backgroundColor: Theme.of(context).primaryColor,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.person,color: Theme.of(context).primaryColor,size: 40,),
          ),
        ),
        SizedBox(height: 15,),
        Card(
          child: ListTile(
            title: Text("Name"),
            subtitle: Text(data["name"]),
          ),
        ),
        Card(
          child: ListTile(
            title: Text("Phone Number"),
            subtitle: Text(data["phone"]),
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: Builder(
          builder: (context){
            return IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back,color: Colors.white,)
            );
          },
        ),
        title: Text("Profile",style:TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            var data = snapshot.data;
            if(data==null){
              return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
            }else{
              return profiledata(data);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          showDialog(context: context, builder: (context)=>UpdateProfile());
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
