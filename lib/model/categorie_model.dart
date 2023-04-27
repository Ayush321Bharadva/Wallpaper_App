class CategoryModel {
  late String catImgUrl;
  late String catName;

  CategoryModel({required this.catImgUrl, required this.catName});

  CategoryModel fromApiToApp(Map<String, dynamic> category) {
    return CategoryModel(
        catImgUrl: category['imgUrl'], catName: category['CategoryName']);
  }
}
