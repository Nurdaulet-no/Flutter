import 'dart:io';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/components/custom_star_rating.dart';
import '../models/clothes.dart';

class JustPage extends StatefulWidget {
  final Clothes clothes;
  final void Function()? onTap;

  JustPage({super.key, required this.clothes, this.onTap});

  @override
  State<JustPage> createState() => _JustPageState();
}

class _JustPageState extends State<JustPage> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  double ratingValue = 5;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(left: 20),
      width: screenWidth * 0.7,
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
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(widget.clothes.imagePaths[index])),
                        fit: BoxFit.cover
                      )
                    ),
                  );
                }
              ),
          ),

          // description
          Expanded(
            flex: 1,
              child: Column(
                children: [
                  // Dots indicator
                  DotsIndicator(
                    dotsCount: widget.clothes.imagePaths.length,
                    position: _currentPage.toDouble(),
                    decorator: DotsDecorator(
                      color: Color(0xFFE0E0E0),
                      activeColor: Colors.grey[500],
                      size: const Size.square(5.0),
                      activeSize: const Size.square(7.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 7),
                    child: Text(
                      widget.clothes.description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500
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
                          padding: const EdgeInsets.only(top: 15),
                          width: screenWidth * 0.5,
                          child: Text(
                            widget.clothes.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Inter',
                              fontSize: 18,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: CustomStarRating(
                            rating: ratingValue,
                            starSize: 20,
                            starSpacing: 0,
                          )
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, top: 5),
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
                                fontSize: 13.5,
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
                                padding: EdgeInsets.all(19),
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

  List<String> europeanSizeOrderMen = [
    "XS", // Extra Small (chest: 88-92 cm)
    "S",  // Small (chest: 92-96 cm)
    "M",  // Medium (chest: 96-100 cm)
    "L",  // Large (chest: 100-104 cm)
    "XL", // Extra Large (chest: 104-108 cm)
    "XXL",// Double Extra Large (chest: 108-112 cm)
    "3XL",// Triple Extra Large (chest: 112-116 cm)
    // ... and so on
  ];
  List<String> sortedSizes = [];

  @override
  void initState() {
    super.initState();
    sortedSizes = widget.clothes.size.toList(); // Create a copy

    sortedSizes.sort((size1, size2) =>
        europeanSizeOrderMen.indexOf(size1).compareTo(europeanSizeOrderMen.indexOf(size2))
    );
  }

  // Dialog
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

                                  // Size
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text(
                                          'EUR:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        flex: 6,
                                        // child: Container(
                                        //   height: 38,
                                        //   color: Colors.green,
                                        // ),
                                        child: SizedBox(
                                          height: 38,
                                          width: 38,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: sortedSizes.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: const EdgeInsets.only(right: 15),
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(color: Colors.grey),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    sortedSizes[index],
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
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
                          margin: const EdgeInsets.only(left: 7, right: 7, top: 20),
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