import 'package:flutter/material.dart';
import 'Search.dart';
import 'Shop.dart';
import 'bag.dart';
import 'profile.dart';
import 'favorites.dart';

class HomePage extends StatefulWidget {
  final String userName;
  const HomePage({super.key, required this.userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> bagItems = [];
  final List<Map<String, dynamic>> favoriteItems = [];

  final List<Map<String, dynamic>> clothes = [
    {
      'name': 'Hoodie (444)',
      'price': 39.99,
      'image': 'images/hoodie.png',
    },
    {
      'name': 'Sweatshirt',
      'price': 29.99,
      'image': 'images/sweatshirt.png',
    },
    {
      'name': 'Sweatpants',
      'price': 39.99,
      'image': 'images/sweatpants.png',
    },
    {
      'name': 'SY Jacket',
      'price': 34.99,
      'image': 'images/jacket.png',
    },
  ];

  int _selectedIndex = 0;

  void _handleSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a search term')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(
          initialQuery: query,
          onAddToBag: _addToBag,
          favoriteItems: favoriteItems,
          onRemoveFromFavorites: _removeFromFavorites,
          onAddToFavorites: _addToFavorites,
        ),
      ),
    );
  }

  void _addToBag(Map<String, dynamic> item) {
    setState(() => bagItems.add(item));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item['name']} added to bag')),
    );
  }

  void _clearBag() {
    setState(() => bagItems.clear());
  }

  void _addToFavorites(Map<String, dynamic> item) {
    if (!favoriteItems.contains(item)) {
      setState(() => favoriteItems.add(item));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${item['name']} added to favorites')),
      );
    }
  }

  void _removeFromFavorites(Map<String, dynamic> item) {
    setState(() => favoriteItems.remove(item));
  }

  void _onNavTapped(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        _handleSearch();
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ShopPage(
              onAddToBag: _addToBag,
              onAddToFavorites: _addToFavorites,
            ),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BagPage(
              bagItems: List.from(bagItems),
              onClearBag: _clearBag,
            ),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FavoritesPage(
              favoriteItems: List.from(favoriteItems),
              onRemoveFromFavorites: _removeFromFavorites,
              onAddToBag: _addToBag,
            ),
          ),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProfilePage(
              userName: widget.userName,
              email: 'user@example.com',
            ),
          ),
        );
        break;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Souly You'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('images/logo.png', height: 80)),
            const SizedBox(height: 10),
            Text(
              'Welcome, ${widget.userName}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search clothing',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => _handleSearch(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Weekly Apparel',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: clothes.length,
                itemBuilder: (context, index) {
                  final item = clothes[index];
                  final isFavorite = favoriteItems.contains(item);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(item['name']),
                      subtitle: Text('\$${item['price']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              isFavorite
                                  ? _removeFromFavorites(item)
                                  : _addToFavorites(item);
                            },
                          ),
                          TextButton(
                            onPressed: () => _addToBag(item),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_bag),
            label: 'Bag (${bagItems.length})',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: 'Favorites (${favoriteItems.length})',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
