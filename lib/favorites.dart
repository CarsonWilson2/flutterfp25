import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteItems;
  final Function(Map<String, dynamic>) onRemoveFromFavorites;
  final Function(Map<String, dynamic>) onAddToBag;

  const FavoritesPage({
    super.key,
    required this.favoriteItems,
    required this.onRemoveFromFavorites,
    required this.onAddToBag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favoriteItems.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return ListTile(
                  leading: Image.asset(
                    item['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item['name']),
                  subtitle: Text('\$${item['price']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_bag),
                        onPressed: () {
                          onAddToBag(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${item['name']} added to bag')),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          onRemoveFromFavorites(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${item['name']} removed from favorites')),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
