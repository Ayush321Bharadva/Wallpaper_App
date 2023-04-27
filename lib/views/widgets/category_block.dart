import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/screens/categories_page.dart';

class CategoryBlock extends StatefulWidget {
  String categoryName;
  String categoryImgSrc;

  CategoryBlock(
      {super.key, required this.categoryImgSrc, required this.categoryName});

  @override
  State<CategoryBlock> createState() => _CategoryBlockState();
}

class _CategoryBlockState extends State<CategoryBlock> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoriesPage(
                catName: widget.categoryName, catImgUrl: widget.categoryImgSrc),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 50,
        width: 100,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.categoryImgSrc,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black12,
              ),
            ),
            Center(
              child: Text(
                widget.categoryName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
