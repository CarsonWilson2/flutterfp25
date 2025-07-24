import 'package:flutter/material.dart';

const List<Map<String, dynamic>> clothes = [
  {
    'name': 'Hoodie (444)',
    'price': 39.99,
    'image': 'images/hoodie.png'
  },
  {
    'name': 'Sweatshirt (224)',
    'price': 39.99,
    'image': 'images/sweatshirt.png'
  },
  {
    'name': 'Sweatpants (224)',
    'price': 34.99,
    'image': 'images/sweatpants.png'
  },
  {
    'name': 'Jacket (22)',
    'price': 29.99,
    'image': 'images/jacket.png'
  },
  {
    'name': 'Hoodie (222)',
    'price': 39.99,
    'image': 'images/hoodie2.png'
  },
  {
    'name': 'Sweatpants SY(grey)',
    'price': 34.99,
    'image': 'images/sweatpantsgrey.png'
  },
  {
    'name': 'Polo(cream white)',
    'price': 29.99,
    'image': 'images/polo.png'
  },
  {
    'name': 'Sweatshirt(green)',
    'price': 39.99,
    'image': 'images/sweatshirtgreen.png'
  },
  {
    'name': 'Hoodie(grey)',
    'price': 39.99,
    'image': 'images/hoodie3.png',
  },
  {
    'name': 'Quarter Zip(black)',
    'price': 29.99,
    'image': 'images/quarterzip.png',
  },
];

class ShopPage extends StatelessWidget {
  final Function(Map<String, dynamic>) onAddToBag;
  final Function(Map<String, dynamic>) onAddToFavorites;

  const ShopPage({
    super.key,
    required this.onAddToBag,
    required this.onAddToFavorites,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Clothing Collection'),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: clothes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.66,
          ),
          itemBuilder: (context, index) {
            final item = clothes[index];
            return ClothingItemCard(
              name: item['name']!,
              price: item['price']!,
              imagePath: item['image']!,
              onAddToBag: () => onAddToBag(item),
              onAddToFavorites: () => onAddToFavorites(item),
            );
          },
        ),
      ),
    );
  }
}

class ClothingItemCard extends StatelessWidget {
  final String name;
  final double price;
  final String imagePath;
  final VoidCallback? onAddToBag;
  final VoidCallback? onAddToFavorites;

  const ClothingItemCard({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
    this.onAddToBag,
    this.onAddToFavorites,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Image
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              child: Container(
                width: double.infinity,
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                ),
              ),
            ),
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onAddToBag,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          textStyle: const TextStyle(fontSize: 13),
                        ),
                        child: const Text('Add to Bag'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: onAddToFavorites,
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.redAccent,
                      tooltip: 'Add to Favorites',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
