import 'package:flutter/material.dart';
import 'package:online_shop/components/just_page.dart';
import 'package:online_shop/components/see_all_page.dart';
import 'package:online_shop/models/clothes.dart';
import 'package:provider/provider.dart';

import '../components/clothes_tile.dart';
import '../components/expand_page.dart';
import '../models/cart.dart';


class ShopPage extends StatefulWidget {
  final List<Clothes> clothes;
  final String userId;
  final bool isGridView;
  final Function(bool) onGridViewToggle;
  const ShopPage({
    super.key,
    required this.clothes,
    required this.userId,
    required this.isGridView,
    required this.onGridViewToggle
  });

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

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
                            if (index < value.getClothesTile().length) {
                              Clothes clothes = value.getClothesTile()[index];
                              // proceed with using `clothes`
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
                                child: JustPage(
                                  clothes: clothes,
                                  onTap: () => addClothesToCart(clothes),
                                ),
                              );
                            } else {
                              print('Index out of range: $index');
                            }
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
                              if (index < value.getClothesTile().length) {
                                Clothes clothes = value.getClothesTile()[index];
                                // proceed with using `clothes`
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
                                  child: SeeAllPage(
                                    clothes: clothes,
                                    onTap: () => addClothesToCart(clothes),
                                  ),
                                );
                              } else {
                                print('Index out of range: $index');
                              }
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
