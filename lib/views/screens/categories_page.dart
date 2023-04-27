import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/api_operations.dart';
import 'package:wallpaper_app/model/photos_model.dart';
import 'package:wallpaper_app/views/screens/fullscreen.dart';
import 'package:wallpaper_app/views/widgets/custom_app_bar.dart';

class CategoriesPage extends StatefulWidget {
  String catName;
  String catImgUrl;

  CategoriesPage({super.key, required this.catName, required this.catImgUrl});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  // List<String> _imageUrls = [];
  late List<PhotosModel> categoryResults;
  bool isLoading = true;

  GetCatRelWall() async {
    categoryResults = await ApiOperations.getSearchedWallpapers(widget.catName);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetCatRelWall();
    super.initState();
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
                  Stack(
                    children: [
                      Image.network(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          widget.catImgUrl),
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black38,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 45),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Category",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300)),
                              Text(
                                widget.catName,
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    // height: MediaQuery.of(context).size.height,
                    height: 700,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 300,
                      ),
                      itemCount: categoryResults.length,
                      itemBuilder: ((context, index) => GridTile(
                            // height: 500,
                            // width: 50,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                        imgUrl: categoryResults[index].imgSrc),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: categoryResults[index].imgSrc,
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
                                      categoryResults[index].imgSrc,
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
