import 'package:flutter/material.dart';
import 'package:online_shop/components/just_page.dart';
import 'package:online_shop/components/see_all_page.dart';
import 'package:online_shop/components/small_cart.dart';
import 'package:online_shop/models/clothes.dart';
import 'package:provider/provider.dart';

import '../components/clothes_tile.dart';
import '../components/expand_page.dart';
import '../models/cart.dart';


class AdminShopPage extends StatefulWidget {
  final List<Clothes> clothes;
  final String userId;
  final bool isGridView;
  final Function(bool) onGridViewToggle;
  const AdminShopPage({
    super.key,
    required this.clothes,
    required this.userId,
    required this.isGridView,
    required this.onGridViewToggle
  });

  @override
  State<AdminShopPage> createState() => _AdminShopPage();
}



class _AdminShopPage extends State<AdminShopPage> {

  @override
  void initState() {
    super.initState();
  }

  void toggleGridView() {
    setState(() {
      widget.onGridViewToggle(!widget.isGridView);
      print('isGridViewShopPage: ${widget.isGridView}');
    });
  }

  //add clothes to cart
  void addClothesToCart(Clothes clothes) {
    Provider.of<Cart>(context, listen: false).addItemToCart(clothes);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Consumer<Cart>(
      builder: (context, value, child) => ListView(
        children: [
          Container(
            height: screenHeight * 0.8,
            child: Column(
              children: [
                // search bar
                Container(
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                            color: Colors.grey
                        ),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            FocusManager.instance.primaryFocus?.unfocus();
                            print('searching');
                          },
                          child: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(left: 10, top: 10)
                    ),
                    style: TextStyle(
                        color: Colors.grey[800]
                    ),
                  ),
                ),

                //message
                const Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  child: Text(
                    'Горячие скидки за каждую вещь💥',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),

                // hot picks
                Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:  [
                      const Text(
                        'Горячие подборки🔥',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: toggleGridView,
                        child: widget.isGridView
                            ? const Text(
                          'Close',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold
                          ),
                        )
                            : const Text(
                          'See all',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 6),

                // list of clothes for sale
                Expanded(
                    child: !widget.isGridView
                        ? ListView.builder(
                        itemCount: value.getClothesTile().length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // get clothes from shop list
                          Clothes clothes = value.getClothesTile()[index];

                          // return the clothes
                          // return the clothes
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExpandPage(
                                    userId: widget.userId,
                                    clothes: widget.clothes,
                                    indexCart: index,
                                  ),
                                ),
                              );
                              print('tapped');
                            },
                            child: SmallCart(
                              clothes: clothes,
                            ),
                          );
                        }
                    )
                        : Padding(
                      padding: const EdgeInsets.only(left: 7, right: 7, top: 20),
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 3,
                              mainAxisSpacing: 3,
                              mainAxisExtent: screenHeight  * 0.4
                          ),
                          itemCount: value.getClothesTile().length,
                          itemBuilder: (context, index) {
                            Clothes clothes = value.getClothesTile()[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ExpandPage(
                                      userId: widget.userId,
                                      clothes: widget.clothes,
                                      indexCart: index,
                                    )
                                    )
                                );
                                print('tapped');
                              },
                              child: SmallCart(
                                clothes: clothes,
                              ),
                            );
                          }
                      ),
                    )
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5, left: 25, right: 25),
                  child: Divider(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
