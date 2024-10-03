import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/models/clothes.dart';

import 'custom_star_rating.dart';

class SmallCart extends StatefulWidget {
  final Clothes clothes;
  const SmallCart({super.key, required this.clothes});

  @override
  State<SmallCart> createState() => _SmallCartState();
}

class _SmallCartState extends State<SmallCart> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  double ratingValue = 5;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.40,
      width: screenWidth * 0.3,
      decoration: const BoxDecoration(
          borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)
          )
      ),
      child: Column(
        children: [
          // clothes pictures with PageView for swipe effect
          Expanded(
            flex: 2,
            child: PageView.builder(
                controller: _pageController,
                itemCount: widget.clothes.imagePaths.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(File(widget.clothes.imagePaths[index])),
                                fit: BoxFit.cover
                            )
                        ),
                      ),

                      // Dots indicator
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: DotsIndicator(
                          dotsCount: widget.clothes.imagePaths.length,
                          position: _currentPage.toDouble(),
                          decorator: DotsDecorator(
                            color: const Color(0xFFE0E0E0),
                            activeColor: Colors.grey[500],
                            size: const Size.square(3.0),
                            activeSize: const Size.square(4.0),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
            ),
          ),

          // price + details + rating stars
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: const BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12)
                        )
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.clothes.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Inter',
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),

                        const SizedBox(height: 5),
                        Align(
                            alignment: Alignment.topLeft,
                            child: CustomStarRating(
                              rating: ratingValue,
                              starSize: 13,
                              starSpacing: 0,
                            )
                        ),

                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.clothes.description,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontSize: 14
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0, top: 0),
                            child: Text(
                              widget.clothes.price + ' тг',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  fontSize: 14
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
