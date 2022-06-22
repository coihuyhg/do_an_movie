import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../models/up_coming_response.dart';

class MovieItemUpComingWidget extends StatelessWidget {
  final Result1 resultEntity;
  final ValueChanged<Result1> onTap;

  const MovieItemUpComingWidget({
    Key? key,
    required this.resultEntity,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call(resultEntity);
      },
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
