import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/widgets/custom_app_bar.dart';


class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    getImages();
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
            Stack(
              children: [
                Image.network(
                  'https://images.pexels.com/photos/1287145/pexels-photo-1287145.jpeg?auto=compress&cs=tinysrgb&w=600',
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black38,
                ),
                Positioned(
                  left: 110,
                  top: 40,
                  child: Column(
                    children: const [
                      Text(
                        'Category',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      Text(
                        'Mountains',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 300,
                ),
                itemCount: 10,
                itemBuilder: ((context, index) => Container(
                      height: 500,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://images.pexels.com/photos/10401968/pexels-photo-10401968.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
                          height: 500,
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
