import 'package:bazaar/screen/dashboard/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogOut extends StatelessWidget {
  const LogOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure?"),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("No",style: TextStyle(color: Colors.green),)
          ),
          TextButton(
              onPressed: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              },
              child: Text("Yes",style: TextStyle(color: Colors.red),)
          ),
        ],
      ),
    );
  }
}
