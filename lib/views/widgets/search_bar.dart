import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

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
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Wallpapers',
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: (){
              print('searching..');
            },
            child: const Icon(Icons.search, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
