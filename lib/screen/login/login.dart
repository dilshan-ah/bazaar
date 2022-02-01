import 'package:bazaar/screen/dashboard/home.dart';
import 'package:bazaar/screen/register/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  logIn() async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailcontroller.text,
          password: _passwordcontroller.text
      );

      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>HomePage()));
      }


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }catch (e) {
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
        title: Text("Login",style:TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                Text("Not registered yet?"),
                SizedBox(width: 20,),
                TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                    },
                    child: Text("Register here")
                )
              ],
            ),
            FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: (){
                  logIn();
                },
                child: Text("Login",style: TextStyle(color: Colors.white),)
            )
          ],
        ),
      ),
    );
  }
}
