import 'package:bazaar/model/category.dart';
import 'package:bazaar/screen/cart/cart.dart';
import 'package:bazaar/screen/category/category.dart';
import 'package:bazaar/screen/drawer/DrawerWidget.dart';
import 'package:bazaar/screen/product/archive.dart';
import 'package:bazaar/screen/product/product_details/single_product.dart';
import 'package:bazaar/screen/search/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _category = Category.generatecategory();

  List carosel = [];

  var firestoreisntance = FirebaseFirestore.instance;

  fetchcarouselImage() async{
    QuerySnapshot qn = await firestoreisntance.collection("carousel-images").get();
    setState(() {
      for(int i=0; i<qn.docs.length; i++){
        carosel.add(
          qn.docs[i]["img-path"]
        );
      }
    });
    return qn.docs;
  }

  List product = [];

  fetchproductdetails()async{
    QuerySnapshot qn = await firestoreisntance.collection("products").get();
    for(int i=0; i<qn.docs.length; i++){
      product.add(
          {
            "product-img":qn.docs[i]["product-img"],
            "product-name":qn.docs[i]["product-name"],
            "product-price":qn.docs[i]["product-price"],
            "product-type":qn.docs[i]["product-type"],
          });
    }
  }

@override
  void initState() {
    fetchproductdetails();
    fetchcarouselImage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: 100,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: Theme.of(context).primaryColor),
          child: InkWell(
            onTap: (){},
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Positioned(
                    bottom: -30,
                    left: 0,
                    right: 0,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Search()));
                      },
                      child: Hero(
                        tag: 'search',
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5), //color of shadow
                                  spreadRadius: 5, //spread radius
                                  blurRadius: 7, // blur radius
                                  offset: Offset(0, 2),
                                )
                              ]),
                          child: ListTile(
                            title: Text("Search products...",style: TextStyle(color: Colors.grey.shade500),),
                            trailing: Icon(Icons.search,color: Theme.of(context).primaryColor,),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
        leading: Builder(
          builder: (ctx) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(ctx).openDrawer();
                },
                icon: Icon(Icons.menu)
            );
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
              },
              icon: Icon(Icons.shopping_cart_outlined)
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 50,),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return Image(image: NetworkImage(carosel[index]),);
                  },
                itemCount: carosel.length,
                separatorBuilder: (_,index)=>SizedBox(width: 15,),
                  ),
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor
                ),),
                TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryPage()));
                    },
                    child: Text("See All",style: TextStyle(
                    color: Theme.of(context).primaryColor
                ),))
              ],
            ),
          ),
          Expanded(
            flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      var category = _category[index];
                      return Card(
                        margin: EdgeInsets.all(5),
                        child: FittedBox(
                          child: Column(
                            children: [
                              Image.asset(category.image,width: 100,height: 100,),
                              SizedBox(height: 10,),
                              Text(category.name,style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold
                              ),),
                              SizedBox(height: 10,)
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_,index)=>SizedBox(width: 10,),
                    itemCount: 4
                ),
              )
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Popular Products",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor
                ),),
                TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Archive(product)));
                    },
                    child: Text("See All",style: TextStyle(
                    color: Theme.of(context).primaryColor
                ),))
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleProduct(product[index])));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width/3,
                          child: Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                Image.network(
                                  product[index]["product-img"],
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: product[index]["product-name"],style: TextStyle(
                                      color: Colors.black,
                                        fontWeight: FontWeight.w500
                                    ),
                                    ),
                                    //
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(product[index]["product-price"].toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                              ],
                            )
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_,index)=>SizedBox(width: 10,),
                    itemCount: 5
                ),
              )
          )
        ],
      ),
    );
  }
}
