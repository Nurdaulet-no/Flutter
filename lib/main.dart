import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:online_shop/models/about_content.dart';
import 'package:online_shop/models/clothes.dart';
import 'package:online_shop/models/user.dart';
import 'package:online_shop/pages/intro_page.dart';
import 'package:online_shop/providers/clothes_provider.dart';
import 'package:provider/provider.dart';


void main() async{
  await Hive.initFlutter();

  // User box
  Hive.registerAdapter(UserAdapter());
  var userBox = await Hive.openBox<User>('userBox');


  // Clothes box
  Hive.registerAdapter(ClothesAdapter());
  var clothesBox = await Hive.openBox<Clothes>('clothesBox');
  // await clothesBox.clear();

  // Cart box
  var cartBox = await Hive.openBox<Map>('cartBox');
  // await cartBox.clear();

  // About box
  Hive.registerAdapter(AboutContentAdapter());
  var aboutBox = await Hive.openBox<AboutContent>('aboutContentBox');


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClothesProvider()),
      ],
      child: const MyApp(),
    )
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}
