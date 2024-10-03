import 'dart:io';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/components/custom_star_rating.dart';
import 'package:online_shop/components/rating_stars_widget.dart';

import '../models/clothes.dart';

class SeeAllPage extends StatefulWidget {
  final Clothes clothes;
  final void Function()? onTap;

  SeeAllPage({super.key, required this.clothes, this.onTap});

  @override
  State<SeeAllPage> createState() => _SeeAllPage();
}

class _SeeAllPage extends State<SeeAllPage> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  double ratingValue = 5;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)
          )
      ),
      child: Column(
        children: [

          // clothes pictures with PageView for swipe effect
          Expanded(
            flex: 3,
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
                            size: const Size.square(4.0),
                            activeSize: const Size.square(6.0),
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

          // description
          Expanded(
              flex: 1,
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
                    child: Text(
                      widget.clothes.description,
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                          fontSize: 13
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
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
                            padding: const EdgeInsets.only(top: 0),
                            width: screenWidth * 0.5,
                            child: Text(
                              widget.clothes.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Inter',
                                fontSize: 17,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: CustomStarRating(
                              rating: ratingValue,
                              starSize: 15,
                            )
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, top: 9),
                              child: Text(
                                widget.clothes.price + ' тг',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize: 15
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ),

                // plus button
                Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12),
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'Add Cart',
                              style: TextStyle(
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                if(widget.onTap != null) {
                                  widget.onTap!();
                                  _showDetailsModal(context);
                                }
                                print('added!');
                              },
                              child: Container(
                                padding: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12)
                                    )
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),
          )

          // button to add to cart

        ],
      ),
    );
  }

  void _showDetailsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 365,
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
              )
          ),

          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)
                        )
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)
                                  )
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child:Container(
                                        margin: EdgeInsets.symmetric(horizontal: 7),
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15)
                                            )
                                        ),
                                        child: Column(
                                          children: [
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                                child: Text(
                                                  'Выберите',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.w700
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: Container(
                                                      height: 80,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: FileImage(File(widget.clothes.imagePaths[0])),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                // Add a description next to the image
                                                Expanded(
                                                  child: Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                                      child: Text(
                                                        widget.clothes.description,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        maxLines: 3,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      child: Container(
                                        decoration:  BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(15)
                                            )
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 25, left: 15),
                                          child: Text(
                                            widget.clothes.price + ' тг',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            )
                        ),
                        Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              color: Colors.grey[100],
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child:  Text(
                                      'Размер: 44-46',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  Row(
                                    children: [
                                      const Text(
                                        'RUS',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const SizedBox(width: 15),

                                      Container(
                                        width: 75,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.grey,
                                            )
                                        ),
                                        child: const Center(
                                          child: Text(
                                              '42-44'
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 7),

                                      Container(
                                        width: 75,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.grey,
                                            )
                                        ),
                                        child: const Center(
                                          child: Text(
                                              '44-46'
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 7),

                                      Container(
                                        width: 75,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.grey,
                                            )
                                        ),
                                        child: const Center(
                                          child: Text(
                                              '46-48'
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            )
                        )
                      ],
                    ),
                  )
              ),

              // добавить в корзину
              Expanded(
                  child: Container(
                    color: Colors.grey[100],

                    child: Column(
                      children: [

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.blue,
                          ),

                          child: const Center(
                            child: Text(
                              'Добавить в корзину',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400
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
        );
      },
    );
  }
}