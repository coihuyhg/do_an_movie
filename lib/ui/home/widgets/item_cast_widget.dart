import 'package:cached_network_image/cached_network_image.dart';
import 'package:do_an_movie/models/cast_response.dart';
import 'package:flutter/material.dart';

class CastItemWidget extends StatelessWidget {
  final Cast castEntity;

  const CastItemWidget({Key? key, required this.castEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: [
          Image(
            image: CachedNetworkImageProvider(
              'https://image.tmdb.org/t/p/original${castEntity.profilePath}',
            ),
            fit: BoxFit.cover,
          ),
          Text('${castEntity.name}'),
          Text('...'),
          Text('${castEntity.character}')
        ],
      ),
    );
  }
}
