class Category{
  String image;
  String name;
  Function url;
  Category(this.image, this.name, this.url);

  static List<Category> generatecategory(){
    return [
      Category('assets/category/vegetable.png', "Vegetables", (){}),
      Category('assets/category/fruit.png', "Fruits", (){}),
      Category('assets/category/fish.png', "Fish", (){}),
      Category('assets/category/meat.png', "Meat", (){}),
      Category('assets/category/cooking.png', "Cooking", (){}),
      Category('assets/category/spices.png', "Spices", (){}),
  ];
}
}