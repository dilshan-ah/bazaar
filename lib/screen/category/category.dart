import 'package:bazaar/model/category.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _categories = Category.generatecategory();
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
        title: Text("All Categories",style:TextStyle(color: Colors.white),),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 200
        ),
        itemBuilder: (context,index){
          var category = _categories[index];
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
        itemCount: _categories.length,
      ),
    );
  }
}
