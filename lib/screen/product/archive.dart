import 'package:bazaar/screen/product/product_details/single_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Archive extends StatefulWidget {
  //const Archive({Key? key}) : super(key: key);

  var products;
  Archive(this.products);


  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  addtocart()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-cart");
    return _collectionRef.doc(currentUser!.email).collection("items").doc().set(
        {
          "name":widget.products["product-name"],
          "price":widget.products["product-price"],
          "image":widget.products["product-img"],
        }
    ).then((value) => print("added to cart"));
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
        title: Text("All Products",style:TextStyle(color: Colors.white),),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 250
          ),
          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleProduct(widget.products[index])));
              },
              child: Container(
                width: 200,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                        child: Image.network(widget.products[index]["product-img"],fit: BoxFit.cover,)
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
                                text: widget.products[index]["product-name"],style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontSize: 18),
                              ),
                            ),
                            SizedBox(width: 50,),
                            Text(widget.products[index]["product-price"]+"৳",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Theme.of(context).primaryColor),)
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
                          onPressed: ()=>addtocart(),
                          child: Text("Add To Cart",style: TextStyle(color: Colors.white),)
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        itemCount: widget.products.length,
      ),
    );
  }
}
