import 'package:flutter/material.dart';
import 'package:slideworks/models/movie_data.dart';
import 'package:slideworks/widgets/movie_card.dart';
import '../api_service.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../widgets/hero_carousel.dart';

class Movielist extends StatefulWidget {
  const Movielist({super.key});

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<Movielist> {
  List<MovieData> _heroMovies = [];
  List<MovieData> _cardListMovies = [];
  bool _isLoading = false;
  String _error = '';
  int _currentPage = 1;
  int? _maxPage;
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadData({int? page}) async {
    final apiUrl = 'https://movies.slideworks.cc/movies?page=${page ?? _currentPage}';

    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final dynamic jsonData = await ApiService.fetchJsonData(apiUrl);
      if (jsonData is Map<String, dynamic>) {
        if (jsonData.containsKey('data')) {
          final List<dynamic> dataList = jsonData['data'];
          final List<MovieData> newItems =
              dataList.map<MovieData>((item) => MovieData.fromJson(item)).toList();

          setState(() {
            if (page == null || page == 1) {
              _heroMovies = newItems.take(4).toList();
              _cardListMovies = newItems.skip(4).toList();
            } else {
              _cardListMovies.addAll(newItems);
            }
            if (jsonData.containsKey('pagination') &&
                jsonData['pagination'] is Map<String, dynamic> &&
                jsonData['pagination'].containsKey('maxPage')) {
              _maxPage = jsonData['pagination']['maxPage'] as int?;
            }
          });
        } else {
          setState(() => _error = 'Error: JSON is missing the element "data"');
        }
      } else {
        setState(() => _error = 'Error: Invalid JSON format');
      }
    } catch (e) {
      setState(() => _error = 'Error loading data: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const Header(
              pathLogo: 'lib/assets/images/logo.png',
              backgroundColor: Color(0xFFFCFCFC),
            ),
            MovieHeroCarousel(movies: _heroMovies),
            _buildContent(),
            const Footer(
              pathLogo: 'lib/assets/images/logo_white.png',
              backgroundColor: Color(0xFF726BEA),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading && _cardListMovies.isEmpty && _heroMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error.isNotEmpty) {
      return Center(
        child: Text(
          _error,
          style: const TextStyle(color: Colors.redAccent),
        ),
      );
    }

    List<Widget> pageButtons = [];

    int startPage = 1;
    int endPage = 5;
    if (_maxPage != null) {
      if (_maxPage! <= 5) {
        endPage = _maxPage!;
      } else if (_currentPage <= 3) {
        endPage = 5;
      } else if (_currentPage + 2 >= _maxPage!) {
        startPage = _maxPage! - 4;
        endPage = _maxPage!;
      } else {
        startPage = _currentPage - 2;
        endPage = _currentPage + 2;
      }
    }

    for (int i = startPage; i <= endPage; i++) {
      pageButtons.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ElevatedButton(
            onPressed: (i == _currentPage) ? null : () => _goToPage(i),
            style: ElevatedButton.styleFrom(
              backgroundColor: (i == _currentPage) ? const Color(0xFF726BEA) : Colors.grey[300],
              foregroundColor: (i == _currentPage) ? Colors.white : Colors.black,
            ),
            child: Text('$i'),
          ),
        ),
      );
    }

    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 1400.0,
        ),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0,
              runSpacing: 8.0,
              children: _cardListMovies.map((movie) {
                return SizedBox(
                  width: 300,
                  child: MovieCard(movie: movie),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0,
                children: pageButtons,
              ),
            ),
            if (_isLoading && _cardListMovies.isNotEmpty)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  void _goToPage(int page) {
    if (page > 0 && (_maxPage == null || page <= _maxPage!)) {
      setState(() {
        _currentPage = page;
        _heroMovies.clear();
        _cardListMovies.clear();
        _loadData(page: _currentPage);
      });

      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}