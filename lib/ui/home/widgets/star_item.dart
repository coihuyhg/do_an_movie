import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarItem extends StatelessWidget {
  double rate;
  StarItem({Key? key, required this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$rate/10',
          style: const TextStyle(fontSize: 32, color: Color(0xFF0F1B2B)),
        ),
        const SizedBox(width: 8),
        RatingBar.builder(
          initialRating: rate / 2,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemSize: 30.0,
          itemPadding: const EdgeInsets.symmetric(horizontal: 0),
          unratedColor: const Color(0x33F8C42F),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Color(0xFFF8C42F),
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
      ],
    );
  }
}
