import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var searchinput = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: 70,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: Theme.of(context).primaryColor),
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Positioned(
                  bottom: -30,
                  left: 0,
                  right: 0,
                  child: Hero(
                    tag: 'search',
                    child: Container(
                      //padding: EdgeInsets.all(15),
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
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: (val){
                            setState(() {
                              searchinput = val;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Builder(
                              builder: (context){
                                return IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Theme.of(context).primaryColor,));
                              },
                            ),
                            hintText: "Search products...",
                            hintStyle: TextStyle(
                                color: Colors.grey.shade500
                            )
                          ),
                        ),
                      )
                    ),
                  ))
            ],
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("products").where("product-tag",isEqualTo: searchinput)
              .snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Center(child: Text("Error has Occured"),);
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: Text("Waiting"),);
            }
            return Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ListView(
                children: snapshot.data!.docs
                    .map((DocumentSnapshot document) {
                  Map<String,dynamic> data =
                  document.data() as Map<String,dynamic>;
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(data['product-name']),
                      subtitle: Text(data['product-price'].toString()),
                      leading: Image.network(data['product-img'],fit: BoxFit.cover,),
                      minLeadingWidth: 50,
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
