import 'package:flutter/material.dart';


class CustomStarRating extends StatelessWidget {
  final double rating;
  final double starSize;
  final double starSpacing;

  CustomStarRating({
    Key? key,
    required this.rating,
    this.starSize = 20,
    this.starSpacing = 4
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(5, (index) {
        return Stack(
          children:[
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: SizedBox(
              child: Icon(
                Icons.star,
                color: index < rating ? Colors.yellow : Colors.grey,
                size: starSize,
              ),
                        ),
            ),
          ]
        );
      }),
    );
  }
}

