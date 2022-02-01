import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SingleProduct extends StatefulWidget {
  var _product;
  SingleProduct(this._product);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {

  addtocart()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-cart");
    return _collectionRef.doc(currentUser!.email).collection("items").doc().set(
      {
        "name":widget._product["product-name"],
        "price":widget._product["product-price"],
        "image":widget._product["product-img"],
      }
    ).then((value) => print("added to cart"));
  }

  addtomonthlygroceries()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-monthly-groceries");
    return _collectionRef.doc(currentUser!.email).collection("items").doc().set(
        {
          "name":widget._product["product-name"],
          "price":widget._product["product-price"],
          "image":widget._product["product-img"],
        }
    ).then((value) => print("added monthly groceries"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Image.network(
                    widget._product["product-img"],
                    fit: BoxFit.cover,
                  )
              ),
              Positioned(
                right: 10,
                  top: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close,color: Theme.of(context).primaryColor,),
                    ),
                  )
              )
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget._product["product-name"],style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 15,),
                  Text(widget._product["product-price"].toString()+"৳",style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 15,),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: 15,),
                  MaterialButton(
                    padding: EdgeInsets.all(15),
                    color: Theme.of(context).primaryColor,
                      minWidth: double.maxFinite,
                      onPressed: ()=>addtocart(),
                      child: Text("Add to cart",style: TextStyle(color: Colors.white),)
                  ),
                  SizedBox(height: 15,),
                  MaterialButton(
                      padding: EdgeInsets.all(15),
                      color: Theme.of(context).primaryColor,
                      minWidth: double.maxFinite,
                      onPressed: ()=>addtomonthlygroceries(),
                      child: Text("Add to monthly groceries",style: TextStyle(color: Colors.white),)
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
