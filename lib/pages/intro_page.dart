import 'package:flutter/material.dart';
import 'package:online_shop/pages/home_page.dart';
import 'package:online_shop/pages/login_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Padding(
                padding: const EdgeInsets.all(25),
                child: Image.asset(
                  'assets/images/img.png',
                  height: 300,
                  width: 250,
                ),
              ),
              const SizedBox(height: 10),

              //title
              const Text(
                'Welcome to THE SELECT',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800
                ),
              ),
              const SizedBox(height: 24),

              //subtitle
              const Text(
                'Buy new urban clothes on low prices',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                ),
              ),
              const SizedBox(height: 48),

              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage()
                  )
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  padding: const EdgeInsets.all(25),
                  child: const Center(
                    child: Text(
                      'Shop Now',
                      style: TextStyle(
                          color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
