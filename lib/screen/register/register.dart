import 'package:bazaar/screen/login/login.dart';
import 'package:bazaar/screen/register/user_data/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  register()async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailcontroller.text,
          password: _passwordcontroller.text
      );
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>UserForm()));
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
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
        title: Text("Register",style:TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15,),
            TextField(
              controller: _emailcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.orange
                  ),
                ),
                hintText: "Email address",
                hintStyle: TextStyle(
                  color: Colors.grey.shade500
                )
              ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: _passwordcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.orange
                    ),
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(
                      color: Colors.grey.shade500
                  )
              ),
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Text("Already registered?"),
                SizedBox(width: 20,),
                TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                    },
                    child: Text("Login here")
                )
              ],
            ),
            FlatButton(
              color: Theme.of(context).primaryColor,
                onPressed: (){
                register();
                },
                child: Text("Register",style: TextStyle(color: Colors.white),)
            )
          ],
        ),
      ),
    );
  }
}
