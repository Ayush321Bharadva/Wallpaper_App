import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/categorie_model.dart';
import 'package:wallpaper_app/model/photos_model.dart';

class ApiOperations {
  static List<PhotosModel> trendingWallpapersList = [];
  static List<PhotosModel> searchedWallpapersList = [];
  static List<CategoryModel> categoryModelList = [];

  static const String _apiKey =
      'qwXsOR3EzotgE8NlcxuTslfgexdGbo8f8hF30W5n6X0q8rso2b1XnmY3';

  //GET wallpapers functions
  static Future<List<PhotosModel>> getTrendingWallpaper() async {
    await http.get(
      Uri.parse('https://api.pexels.com/v1/curated'),
      headers: {'Authorization': _apiKey},
    ).then((response) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List photos = jsonData['photos'];
      for (var element in photos) {
        trendingWallpapersList.add(PhotosModel.fromApiToApp(element));
        // PhotosModel.fromApiToApp(element);
        // Map<String, dynamic> src = element['src'];
        // print(src['portrait']);
      }
    });
    return trendingWallpapersList;
  }

  //search wallpaper function
  static Future<List<PhotosModel>> getSearchedWallpapers(String query) async {
    await http.get(
      Uri.parse(
          'https://api.pexels.com/v1/search?query=$query&per_page=100&page=1'),
      headers: {'Authorization': _apiKey},
    ).then((response) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List photos = jsonData['photos'];
      searchedWallpapersList.clear();
      for (var element in photos) {
        searchedWallpapersList.add(PhotosModel.fromApiToApp(element));
      }
    });
    return searchedWallpapersList;
  }

  //categories Section
  static List<CategoryModel> getCategoriesList() {
    List categoryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers",
    ];
    categoryModelList.clear();
    categoryName.forEach((catname) async {
      final random = Random();

      PhotosModel photosModel =
          (await getSearchedWallpapers(catname))[0 + random.nextInt(11 - 0)];
      categoryModelList.add(
          CategoryModel(catImgUrl: photosModel.imgSrc, catName: catname));
    });
    return categoryModelList;
  }
}
