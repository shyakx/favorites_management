// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorites.dart';
import 'favorites_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Favorites(),
      child: MaterialApp(
        title: 'Favorites Management App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductListScreen(),
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  final List<String> products = List.generate(26, (index) => 'Product $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: ListTile(
              title: Text(product),
              trailing: Consumer<Favorites>(
                builder: (context, favorites, child) {
                  final isFavorite = favorites.items.contains(product);
                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      isFavorite
                          ? favorites.removeItem(product)
                          : favorites.addItem(product);
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => FavoritesScreen()),
          );
        },
      ),
    );
  }
}
