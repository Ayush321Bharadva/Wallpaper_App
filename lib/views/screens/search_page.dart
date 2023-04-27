import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/api_operations.dart';
import 'package:wallpaper_app/model/photos_model.dart';
import 'package:wallpaper_app/views/screens/fullscreen.dart';
import 'package:wallpaper_app/views/widgets/custom_app_bar.dart';
import 'package:wallpaper_app/views/widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  String query;

  SearchPage({super.key, required this.query});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<PhotosModel> searchResults;
  bool isLoading = true;

  GetSearchResults() async {
    searchResults = await ApiOperations.getSearchedWallpapers(widget.query);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetSearchResults();
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SearchBar(),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
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
                      itemCount: searchResults.length,
                      itemBuilder: ((context, index) => GridTile(
                            // height: 600,
                            // width: 50,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                      imgUrl: searchResults[index].imgSrc,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: searchResults[index].imgSrc,
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
                                      searchResults[index].imgSrc,
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
