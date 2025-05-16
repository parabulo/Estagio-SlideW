import 'package:flutter/material.dart';
import 'package:slideworks/models/movie_data.dart';
import 'package:slideworks/widgets/movie_card.dart';
import '../api_service.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';

class Movielist extends StatefulWidget {
  const Movielist({super.key});

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<Movielist> {
  List<MovieData> _items = [];
  bool _isLoading = false;
  String _error = '';
  int _currentPage = 1;
  int? _maxPage;
  static const int _moviesPerPage = 10;
  bool _hasMoreData = true;
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
              _items = newItems;
            } else {
              _items.addAll(newItems);
            }
            if (jsonData.containsKey('max_page')) {
              _maxPage = jsonData['max_page'];
              _hasMoreData = _maxPage == null || _currentPage < _maxPage!;
            } else {
              if (newItems.length < _moviesPerPage) {
                _hasMoreData = false;
              }
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
      appBar: AppBar(title: const Text('Teste')),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const Header(
              pathLogo: AssetImage('lib/assets/images/logo.png'),
              backgroundColor: Color(0xFFFCFCFC),
            ),
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
    if (_isLoading && _items.isEmpty) {
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

    if (_items.isEmpty) {
      return const Center(
        child: Text("No movies to show."),
      );
    }

    List<Widget> pageButtons = [];

    int startPage = (_currentPage - 1 > 0) ? _currentPage - 1 : 1;
    int endPage = (_maxPage != null && _currentPage + 1 <= _maxPage!)
        ? _currentPage + 1
        : (_maxPage != null ? _maxPage! : _currentPage + 1);

    for (int i = startPage; i <= endPage; i++) {
      if (i != _currentPage) {
        pageButtons.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ElevatedButton(
              onPressed: () => _goToPage(i),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
              ),
              child: Text('$i'),
            ),
          ),
        );
      } else {
        pageButtons.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF726BEA),
                foregroundColor: Colors.white,
              ),
              child: Text('$i'),
            ),
          ),
        );
      }
    }

    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 1400.0,
        ),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0,
              runSpacing: 8.0,
              children: _items.map((movie) {
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
            if (_isLoading && _items.isNotEmpty)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            if (!_isLoading && !_hasMoreData && _items.isNotEmpty)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('No more movies to load.'),
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
        _items.clear();
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