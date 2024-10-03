import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class RatingStarsWidget extends StatefulWidget {
  final double initialValue;
  final void Function(double) onValueChanged;
  final double starSize;

   RatingStarsWidget({
    Key? key,
    required this.initialValue,
    required this.onValueChanged,
    this.starSize = 20
  }) : super(key: key);

  @override
  State<RatingStarsWidget> createState() => _RatingStarsWidgetState();
}

class _RatingStarsWidgetState extends State<RatingStarsWidget> {
  late double value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return RatingStars(
      value: value,
      onValueChanged: (v) {
        setState(() {
          value = v;
        });
        widget.onValueChanged(v);
      },
      starBuilder: (index, color) => Icon(
        Icons.star,
        color: color,
      ),
      starCount: 5,
      starSize: widget.starSize,
      valueLabelColor: const Color(0xff9b9b9b),
      valueLabelRadius: 10,
      maxValue: 5,
      starSpacing: 2,
      maxValueVisibility: false,
      valueLabelVisibility: false,
      animationDuration: Duration(milliseconds: 1000),
      starOffColor: const Color(0xffe7e8ea),
      starColor: Colors.yellow,
    );
  }
}
