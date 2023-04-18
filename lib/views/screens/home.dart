import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/api_operations.dart';
import 'package:wallpaper_app/model/photosmodel.dart';
import 'package:wallpaper_app/views/widgets/category_block.dart';
import 'package:wallpaper_app/views/widgets/custom_app_bar.dart';
import 'package:wallpaper_app/views/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   List<String> _imageUrls = [];
   // late List<PhotosModel> trendingWallList ;
   List<PhotosModel> trendingWallList = [];

   GetTrendingWallpapers() async {
      trendingWallList = await ApiOperations.getTrendingWallpaper();
   }

  @override
  void initState() {
    super.initState();
    GetTrendingWallpapers();
    // getImages();
  }

  Future<void> getImages() async {
    final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/curated'),
      headers: {
        'Authorization':
            'qwXsOR3EzotgE8NlcxuTslfgexdGbo8f8hF30W5n6X0q8rso2b1XnmY3',
      },
    );
    final data = jsonDecode(response.body);
    final List<dynamic> photos = data['photos'];
    final List<String> imageUrls =
        photos.map((photo) => photo['src']['portrait'].toString()).toList();
    setState(() {
      _imageUrls = imageUrls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const SearchBar(),
            ),
            //categories
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) => const CategoryBlock()),
                ),
              ),
            ),
            //images
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              // height: MediaQuery.of(context).size.height,
              height: 600,
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 300,
                ),
                itemCount: trendingWallList.length,
                itemBuilder: ((context, index) => Container(
                      height: 600,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          trendingWallList[index].imgSrc,
                          height: 600,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
      // body: GridView.builder(
      //   padding: const EdgeInsets.all(8.0),
      //   itemCount: _imageUrls.length,
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 1,
      //     mainAxisSpacing: 8,
      //     crossAxisSpacing: 8,
      //   ),
      //   itemBuilder: (context, index) {
      //     return Image.network(
      //       _imageUrls[index],
      //       fit: BoxFit.cover,
      //       loadingBuilder: (context, child, progress) {
      //         return progress == null
      //             ? child
      //             : const Center(child: CircularProgressIndicator());
      //       },
      //       errorBuilder: (context, error, stackTrace) {
      //         return const Icon(Icons.error);
      //       },
      //     );
      //   },
      // ),
    );
  }
}
