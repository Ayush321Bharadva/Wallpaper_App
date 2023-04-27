import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/api_operations.dart';
import 'package:wallpaper_app/model/categorie_model.dart';
import 'package:wallpaper_app/model/photos_model.dart';
import 'package:wallpaper_app/views/screens/fullscreen.dart';
import 'package:wallpaper_app/views/widgets/category_block.dart';
import 'package:wallpaper_app/views/widgets/custom_app_bar.dart';
import 'package:wallpaper_app/views/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late List<PhotosModel> trendingWallList ;
  List<PhotosModel> trendingWallList = [];
  List<CategoryModel> catModList = [];
  bool isLoading = true;

  GetCatDetails() async {
    catModList = await ApiOperations.getCategoriesList();
    setState(() {
      catModList = catModList;
    });
  }

  GetTrendingWallpapers() async {
    trendingWallList = await ApiOperations.getTrendingWallpaper();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetTrendingWallpapers();
    GetCatDetails();
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  //search bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SearchBar(),
                  ),

                  //categories
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: catModList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) => CategoryBlock(
                              categoryImgSrc: catModList[index].catImgUrl,
                              categoryName: catModList[index].catName,
                            )),
                      ),
                    ),
                  ),

                  //images/Wallpapers Section
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height,
                    // height: 600,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 400,
                      ),
                      itemCount: trendingWallList.length,
                      itemBuilder: ((context, index) => GridTile(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                        imgUrl: trendingWallList[index].imgSrc),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: trendingWallList[index].imgSrc,
                                child: Container(
                                  height: 600,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.cyan,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      trendingWallList[index].imgSrc,
                                      height: 600,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
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
