import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/screens/search_page.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search Wallpapers',
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SearchPage(query: _searchController.text),
                ),
              );
            },
            child: const Icon(Icons.search, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
