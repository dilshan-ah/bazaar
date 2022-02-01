import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
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
        title: Text("Cart",style:TextStyle(color: Colors.white),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users-cart").doc(FirebaseAuth.instance.currentUser!.email).collection("items").snapshots(),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Text(("Something went wrong"));
          }else if(snapshot.data == null){
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/empty_images/empty cart.png"),
                  Text("Cart is Empty",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 30,fontWeight: FontWeight.bold),)
                ],
              );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index){
              DocumentSnapshot _documentsnapshot = snapshot.data!.docs[index];
              return ListTile(
                leading: Text(_documentsnapshot["name"]),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(_documentsnapshot["price"]),
                      IconButton(
                          onPressed: (){
                            FirebaseFirestore.instance.collection("users-cart").doc(FirebaseAuth.instance.currentUser!.email).collection("items").doc(_documentsnapshot.id).delete();
                          },
                          icon: Icon(Icons.delete,color: Colors.red,)
                      )
                    ],
                  ),
                ),
              );
              }
              );
        },
      ),
    );
  }
}
