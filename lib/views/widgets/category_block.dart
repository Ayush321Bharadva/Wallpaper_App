import 'package:flutter/material.dart';

class CategoryBlock extends StatelessWidget {
  const CategoryBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 50,
      width: 100,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              'https://images.pexels.com/photos/1383834/pexels-photo-1383834.jpeg?auto=compress&cs=tinysrgb&w=600',
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
          const Positioned(
            left: 32,
            top: 12,
            child: Text(
              'Cars',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
