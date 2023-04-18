import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/photosmodel.dart';

class ApiOperations {
  static List<PhotosModel> trendingWallpapersList = [];
  static List<PhotosModel> searchedWallpapersList = [];

  //GET wallpapers functions
  static Future<List<PhotosModel>> getTrendingWallpaper() async {
    await http.get(
      Uri.parse('https://api.pexels.com/v1/curated'),
      headers: {
        'Authorization':
            'qwXsOR3EzotgE8NlcxuTslfgexdGbo8f8hF30W5n6X0q8rso2b1XnmY3'
      },
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
      Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=100&page=1'),
      headers: {
        'Authorization':
            'qwXsOR3EzotgE8NlcxuTslfgexdGbo8f8hF30W5n6X0q8rso2b1XnmY3'
      },
    ).then((response) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List photos = jsonData['photos'];
      searchedWallpapersList.clear();
      for(var element in photos){
        searchedWallpapersList.add(PhotosModel.fromApiToApp(element));
      }
    });
    return searchedWallpapersList;
  }
// Future<void> getImages() async {
//   final response = await http.get(
//     Uri.parse('https://api.pexels.com/v1/curated'),
//     headers: {
//       'Authorization':
//       'qwXsOR3EzotgE8NlcxuTslfgexdGbo8f8hF30W5n6X0q8rso2b1XnmY3',
//     },
//   );
//   final data = jsonDecode(response.body);
//   final List<dynamic> photos = data['photos'];
//   final List<String> imageUrls =
//   photos.map((photo) => photo['src']['portrait'].toString()).toList();
//   // setState(() {
//   //   _imageUrls = imageUrls;
//   // });
// }
}
