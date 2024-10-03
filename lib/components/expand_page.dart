import 'dart:io';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/components/small_cart.dart';
import 'package:online_shop/models/cart.dart';
import 'package:online_shop/pages/home_page.dart';
import 'package:provider/provider.dart';

import '../models/clothes.dart';
import 'custom_star_rating.dart';

class ExpandPage extends StatefulWidget {
  final String userId;
  final List<Clothes> clothes;
  final int indexCart;
  const ExpandPage({Key? key, required this.userId,required this.clothes, required this.indexCart}) : super(key: key);

  @override
  State<ExpandPage> createState() => _ExpandPageState();
}

class _ExpandPageState extends State<ExpandPage> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  int _selectedIndex = -1;
  int _selectedSize = -1;
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

    // Проверка, что индекс существует перед доступом к нему
    if (widget.clothes.isNotEmpty && widget.indexCart < widget.clothes.length) {
      sortedSizes = widget.clothes[widget.indexCart].size.toList(); // Create a copy

      sortedSizes.sort((size1, size2) =>
          europeanSizeOrderMen.indexOf(size1).compareTo(europeanSizeOrderMen.indexOf(size2))
      );
    } else {
      // Обработка ошибки или назначение значений по умолчанию
      sortedSizes = [];
      print('Invalid indexCart or clothes list is empty');
    }
  }


  @override
  Widget build(BuildContext context) {
    Clothes currentClothes = widget.clothes[widget.indexCart];
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => Cart(widget.userId),
      builder: (context, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Padding(
                    padding:  EdgeInsets.only(left: 10, top: 25),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  onPressed: () {
                    // I did it then I cant tap back button. Why?
                    Navigator.pop(context);
                  },
                ),
              ),
              centerTitle: true,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 35, left: 50, right: 15),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
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
                ),
              ),
            ),
          ),
          backgroundColor: Colors.grey[200],
          body: ListView(
            children: [

              // Clothes
              Container(
                color: Colors.grey[200],
                child: Column(
                  children: [

                    // PageView for images
                    SizedBox(
                      height: screenHeight * 0.5, // Fixed height for PageView
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: currentClothes.imagePaths.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(File(currentClothes.imagePaths[index])),
                                fit: BoxFit.cover,
                              ),
                            ),
                            margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                          );
                        },
                      ),
                    ),

                    // Name + Rating + Other details
                    Container(
                      height: screenHeight * 0.55, // Fixed height for this section
                      width: screenWidth * 1,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),

                          // Dots indicator
                          Align(
                            alignment: Alignment.topCenter,
                            child: DotsIndicator(
                              dotsCount: currentClothes.imagePaths.length,
                              position: _currentPage.toDouble(),
                              decorator: DotsDecorator(
                                color: const Color(0xFFE0E0E0),
                                activeColor: Colors.grey[500],
                                size: const Size.square(5.0),
                                activeSize: const Size.square(7.0),
                                activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                ),
                              ),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Divider(),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                currentClothes.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Inter',
                                  fontSize: 21,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: CustomStarRating(
                                  rating: 20,
                                  starSize: 20,
                                  starSpacing: 0,
                                )
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Divider(),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 9),
                                child: Text(
                                  currentClothes.price + ' тг',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 18
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Divider(),
                          ),
                          const Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 10),
                            child:  Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Цвет: ' + '?',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight:FontWeight.w500
                                ),
                              ),
                            ),
                          ),


                          Row(
                            children: List.generate(currentClothes.imagePaths.length, (index) {
                              bool isSelected = _selectedIndex == index;
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10, top: 10),
                                  height: screenHeight * 0.1,
                                  width: screenWidth * 0.2,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(File(currentClothes.imagePaths[0])),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: isSelected ? BorderRadius.circular(10) : BorderRadius.circular(7),
                                    border: Border.all(
                                      color: isSelected ? Colors.blueAccent : Colors.black,
                                      width: isSelected ? 3 : 2,
                                    ),
                                  ),
                                ),
                              );
                            }
                            ),
                          ),


                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Text(
                                'Размер: ${sortedSizes[0]} - ${sortedSizes[sortedSizes.length-1]}',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Size
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'EUR:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 6,
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
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
                          const Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Divider(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: screenHeight * 0.35, // Fixed height for this section
                width: screenWidth * 1,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 1,
                      child:  Text(
                        'Основные характеристики',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),

                    Expanded(
                      flex:8,
                      child: Row(
                        children: [
                          const Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Модель',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'Тип силуэта',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'Размер',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'Карманы',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'Рукава',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'Состав',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'Сезон',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'Застежка',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'Страна производства',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),

                                ],
                              )
                          ),
                          Expanded(
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.clothes[widget.indexCart].characteristics['Модель']!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    widget.clothes[widget.indexCart].characteristics['Тип силуэта']!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    sortedSizes[0],
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    widget.clothes[widget.indexCart].characteristics['Карманы']!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    widget.clothes[widget.indexCart].characteristics['Рукава']!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    widget.clothes[widget.indexCart].characteristics['Состав']!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    widget.clothes[widget.indexCart].characteristics['Сезон']!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    widget.clothes[widget.indexCart].characteristics['Застежка']!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),

                                  Text(
                                    widget.clothes[widget.indexCart].characteristics['Страна производства']!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Container(
                height: screenHeight * 0.97,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 15),

                    Expanded(
                      child: Column(
                        children: [
                          Consumer<Cart>(
                            builder: (context, value, child) {
                              List<Clothes> clothesList = value.getClothesTile();
                              List<Widget> rows = [];
                              List<Clothes> filteredClothesList = clothesList.where((clothes) =>
                              clothes.clothesId != widget.clothes[widget.indexCart].clothesId
                              ).toList();

                              if(filteredClothesList.length >= 1){
                                for(int i = 0; i < filteredClothesList.length; i+=2) {
                                  print('length of filteredClothesList: ${filteredClothesList.length}');
                                  print('name: ${filteredClothesList[i].name}');

                                  List<Widget> rowChildren = [];

                                  // first row
                                  rowChildren.add(GestureDetector(
                                    onTap: () {
                                      print('tapped to first row');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => ExpandPage(
                                              userId: widget.userId,
                                              clothes: clothesList,
                                              indexCart: widget.clothes.indexOf(filteredClothesList[i])
                                          ))
                                      );
                                    },
                                    child: Container(
                                      width: (MediaQuery.of(context).size.width - 30) / 2, // Adjust width for two items per row
                                      child: SmallCart(clothes: filteredClothesList[i]),
                                    ),
                                  ));

                                  // Добавление пространства между элементами
                                  rowChildren.add(const SizedBox(width: 10));

                                  // second row
                                  if(i + 1 < filteredClothesList.length){
                                    rowChildren.add(GestureDetector(
                                      onTap: () {
                                        print('tapped to second row');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ExpandPage(
                                                userId: widget.userId,
                                                clothes: clothesList,
                                                indexCart: widget.clothes.indexOf(filteredClothesList[i+1])
                                            ))
                                        );
                                      },
                                      child:  Container(
                                        width: (MediaQuery.of(context).size.width - 30) / 2, // Adjust width for two items per row
                                        child: SmallCart(clothes: filteredClothesList[i+1]),
                                      ),
                                    ));
                                  }else{
                                    rowChildren.add(Container(width: (MediaQuery.of(context).size.width-30)/2));
                                  }

                                  rows.add(Row(children: rowChildren));
                                  // Добавление Divider между строками
                                  if (i + 2 < clothesList.length) {
                                    rows.add(const Divider());
                                  }
                                }
                              }

                              return Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Column(children: rows),
                              );
                            },
                          ),
                        ],
                      )
                    ),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage(userId: widget.userId))
                        );
                      },
                      child: Container(
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.35,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Go Home',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.blueGrey
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }

  //add clothes to cart
  void addClothesToCart(Clothes clothes) {
    Provider.of<Cart>(context, listen: false).addItemToCart(clothes);
  }
}
