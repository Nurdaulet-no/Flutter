import 'package:flutter/material.dart';
import 'dart:io';
import '../models/clothes.dart';

class TrashPage extends StatefulWidget {
  final Clothes clothes;
  final void Function()? onTap;

  TrashPage({super.key, required this.clothes, this.onTap});

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
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

          Expanded(
            flex: 3,
            child: Container(
              color: Colors.green,
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(
              color: Colors.red,
            ),
          ),

          Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                        color: Colors.greenAccent
                    ),
                  ),

                  Expanded(
                    child: Container(
                      color: Colors.lightBlue,
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
