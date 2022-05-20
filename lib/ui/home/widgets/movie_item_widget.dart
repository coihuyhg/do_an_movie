import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../models/now_play_response.dart';

class MovieItemWidget extends StatelessWidget {
  final Result resultEntity;

  const MovieItemWidget({
    Key? key,
    required this.resultEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 7,
              child: Image(
                width: double.infinity,
                image: CachedNetworkImageProvider(
                    'https://image.tmdb.org/t/p/original${resultEntity.posterPath}',
                    maxHeight: 250),
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              flex: 1,
              child: Text(
                resultEntity.title ?? '',
                style: const TextStyle(fontSize: 18, color: Color(0xFF0F1B2B)),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${resultEntity.voteAverage ?? ''} ⭐',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 10),
                Text(
                  '${resultEntity.voteCount ?? ''} 👍',
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
