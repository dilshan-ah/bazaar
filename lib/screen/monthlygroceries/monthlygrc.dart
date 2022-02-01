import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Monthlygrc extends StatefulWidget {
  const Monthlygrc({Key? key}) : super(key: key);

  @override
  _MonthlygrcState createState() => _MonthlygrcState();
}

class _MonthlygrcState extends State<Monthlygrc> {
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
        title: Text("Monthly groceries",style:TextStyle(color: Colors.white),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users-monthly-groceries").doc(FirebaseAuth.instance.currentUser!.email).collection("items").snapshots(),
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
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 250
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              DocumentSnapshot _documentsnapshot = snapshot.data!.docs[index];
              return Container(
                width: 200,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 3,
                        child: Image.network(_documentsnapshot["image"],fit: BoxFit.cover,)
                    ),
                    SizedBox(height: 20,),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: _documentsnapshot["name"],style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontSize: 18),
                              ),
                            ),
                            SizedBox(width: 50,),
                            Text(_documentsnapshot["price"]+"৳",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Theme.of(context).primaryColor),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Flexible(
                      flex: 1,
                      child: FlatButton(
                          minWidth: 220,
                          color: Theme.of(context).primaryColor,
                          onPressed: (){
                            FirebaseFirestore.instance.collection("users-monthly-groceries").doc(FirebaseAuth.instance.currentUser!.email).collection("items").doc(_documentsnapshot.id).delete();
                          },
                          child: Text("Delete",style: TextStyle(color: Colors.white),)
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
