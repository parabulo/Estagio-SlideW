import 'package:flutter/material.dart';
import 'package:slideworks/models/movie_data.dart';

class MovieCard extends StatelessWidget {
  final MovieData movie;

  const MovieCard({
    super.key,
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 700,
      ),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (movie.bannerPath.isNotEmpty)
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.network(
                movie.bannerPath,
                height: 450.0,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 150.0,
                    width: double.infinity,
                    child: Center(
                      child: Icon(Icons.image_not_supported_outlined),
                    ),
                  );
                },
              ),
            ),  
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text('Ano de Lançamento: ${movie.launchYear}'),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 6),
                    child: Text(
                      movie.credits,
                      style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ),
                  const Spacer(),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Color(0x92726BEA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Color(0xFFFCFCFC)),
                            const SizedBox(width: 5),
                            Text('${movie.rating}/10',
                              style: TextStyle(
                                color: Color(0xFFFCFCFC)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}