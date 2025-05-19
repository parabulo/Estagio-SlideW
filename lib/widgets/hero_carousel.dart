import 'package:flutter/material.dart';
import 'package:slideworks/models/movie_data.dart';
import 'dart:async';

class MovieHeroCarousel extends StatefulWidget {
  const MovieHeroCarousel({super.key, required this.movies});

  final List<MovieData> movies;

  @override
  State<MovieHeroCarousel> createState() => _MovieHeroCarouselState();
}

class _MovieHeroCarouselState extends State<MovieHeroCarousel> {
  int _currentMovieIndex = 0;
  PageController _pageController = PageController();
  late Timer _timer;

  void _nextMovie() {
    if (mounted && widget.movies.isNotEmpty) {
      setState(() {
        _currentMovieIndex = (_currentMovieIndex + 1) % widget.movies.length;
      });
      _pageController.animateToPage(
        _currentMovieIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousMovie() {
    if (mounted && widget.movies.isNotEmpty) {
      setState(() {
        _currentMovieIndex =
            (_currentMovieIndex - 1 + widget.movies.length) %
                widget.movies.length;
      });
       _pageController.animateToPage(
        _currentMovieIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentMovieIndex);
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      _nextMovie();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) {
      return const SizedBox.shrink();
    }

    final currentMovie = widget.movies[_currentMovieIndex];

    return SizedBox(
      width: double.infinity,
      height: 600,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.movies.length,
            onPageChanged: (index) {
              setState(() {
                _currentMovieIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              return Image.network(
                movie.bannerPath,
                fit: BoxFit.cover,
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: _previousMovie,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: _nextMovie,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 20.0, top: 0.0, end: 20.0, bottom: 60.0),
            child: Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 900.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Destaques:',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      currentMovie.title,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentMovie.launchYear,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
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
                              const SizedBox(width: 5,),
                              Text('${currentMovie.rating}/10',
                                style: TextStyle(
                                  color: Color(0xFFFCFCFC)
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(9),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                currentMovie.credits,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white60,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    if (widget.movies.isNotEmpty) {
      for (int i = 0; i < widget.movies.length; i++) {
        indicators.add(
          _buildIndicator(i == _currentMovieIndex),
        );
      }
    }
    return indicators;
  }

  Widget _buildIndicator(bool isCurrentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isCurrentPage ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.white : Colors.white30,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}