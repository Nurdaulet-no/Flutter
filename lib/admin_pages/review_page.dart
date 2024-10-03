import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, value, child) => Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.green,
          ),
        )
      ],
    ));
  }
}
