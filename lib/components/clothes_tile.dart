import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/models/clothes.dart';

class ClothesTile extends StatefulWidget {
  final Clothes clothes;
  final void Function()? onTap;

  ClothesTile({Key? key, required this.clothes, required this.onTap}) : super(key: key);

  @override
  _ClothesTileState createState() => _ClothesTileState();
}

class _ClothesTileState extends State<ClothesTile> {
  PageController _pageController = PageController();
  int _currentPage = 0;

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
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // clothes pictures with PageView for swipe effect
          Container(
            margin: const EdgeInsets.only(left: 0),
            height: 300,
            width: screenWidth * 0.7,
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
                      image: AssetImage(widget.clothes.imagePaths[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          // Dots indicator
          DotsIndicator(
            dotsCount: widget.clothes.imagePaths.length,
            position: _currentPage.toDouble(),
            decorator: DotsDecorator(
              activeColor: Colors.grey[800],
              size: const Size.square(9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
          ),

          // description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              widget.clothes.description,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // price + details
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 1, bottom: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // clothes name
                    Container(
                      width: screenWidth * 0.5,
                      child: Text(
                        widget.clothes.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // price
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, left: 5),
                      child: Text(
                        widget.clothes.price + ' тг',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),

                // plus button with InkWell for click effect
                InkWell(
                  onTap: () {
                    if (widget.onTap != null) {
                      widget.onTap!();
                    }
                    print('added!');
                  },
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(17),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )

          // button to add to cart
        ],
      ),
    );
  }
}
