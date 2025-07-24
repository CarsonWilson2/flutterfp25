import 'package:flutter/material.dart';
import 'shop.dart';
import 'favorites.dart';

class SearchPage extends StatefulWidget {
  final String initialQuery;
  final Function(Map<String, dynamic>) onAddToBag;

  final List<Map<String, dynamic>> favoriteItems;
  final Function(Map<String, dynamic>) onRemoveFromFavorites;
  final Function(Map<String, dynamic>) onAddToFavorites;

  const SearchPage({
    super.key,
    required this.initialQuery,
    required this.onAddToBag,
    required this.favoriteItems,
    required this.onRemoveFromFavorites,
    required this.onAddToFavorites,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController _controller;
  late List<Map<String, dynamic>> _filteredResults;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
    _filterResults(widget.initialQuery);
  }

  void _filterResults(String query) {
    final lowerQuery = query.toLowerCase();
    setState(() {
      _filteredResults = clothes.where((item) {
        final name = (item['name'] as String).toLowerCase();
        return name.contains(lowerQuery);
      }).toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search clothes...',
            border: InputBorder.none,
          ),
          onChanged: _filterResults,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Favorites',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(
                    favoriteItems: List.from(widget.favoriteItems),
                    onRemoveFromFavorites: widget.onRemoveFromFavorites,
                    onAddToBag: widget.onAddToBag,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: _filteredResults.isEmpty
          ? const Center(
              child: Text(
                'No matching items found.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: _filteredResults.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final item = _filteredResults[index];
                  return ClothingItemCard(
                    name: item['name'],
                    price: item['price'],
                    imagePath: item['image'],
                    onAddToBag: () => widget.onAddToBag(item),
                  );
                },
              ),
            ),
    );
  }
}
