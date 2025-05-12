import 'package:flutter/material.dart';
import 'package:slideworks/models/movie_data.dart';
import '../api_service.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';

class Movielist extends StatefulWidget{
  const Movielist({super.key});

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<Movielist> {
  List<MovieData> items = [];
  bool isLoading = false;
  String error = '';

  Future<void> loadData() async {
    const apiUrl = 'https://movies.slideworks.cc/movies?';

    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      final dynamic jsonData = await ApiService.fetchJsonData(apiUrl);
      if(jsonData is Map<String, dynamic> && jsonData.containsKey('data')) {
        final List<dynamic> dataList = jsonData['data'];
        setState(() {
          items = dataList.map<MovieData>((item) => MovieData.fromJson(item)).toList();
        });
      } else {
        setState(() => error = 'Error: JSON is missing the element "DATA"');
      }
    } catch (e) {
      setState(() => error = 'Error loading data: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState(){
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Teste')),
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: loadData,
        child: const Icon(Icons.refresh)
      )
    );
  }

  Widget _buildContent() {
    if(isLoading){
      return const Center(child: CircularProgressIndicator());
    }

    if(error.isNotEmpty) {
      return Center(child: Text(error, style: const TextStyle(color: Colors.redAccent),),);
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item.title),
        );
      },
    );
  }
}