import 'package:flutter/material.dart';
import 'package:my_grocery/app_drawer.dart';

class Product {
  String name;
  double price;
  String unit;
  String farm;
  String image;

  Product({
    required this.name,
    required this.price,
    required this.unit,
    required this.farm,
    required this.image,
  });
}

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  List<Product> products = [
    Product(
      name: 'Garlic clove',
      price: 0.89,
      unit: 'each',
      farm: 'Kunisaki Farms',
      image: 'https://images7.alphacoders.com/413/thumb-1920-413324.jpg',
    ),
    Product(
      name: 'Sugar snap pea',
      price: 2.29,
      unit: '/lb',
      farm: 'Helmbolt Orchards',
      image: 'assets/sugar_snap_pea.jpg',
    ),
    Product(
      name: 'Ginger',
      price: 4.20,
      unit: '/lb',
      farm: 'Bui Farms',
      image: 'assets/ginger.jpg',
    ),
    Product(
      name: 'Sweet onion',
      price: 0.39,
      unit: '/lb',
      farm: 'Castelao Farms',
      image: 'assets/sweet_onion.jpg',
    ),
    Product(
      name: 'Raspberries',
      price: 3.99,
      unit: 'pint',
      farm: 'Bernal Growers',
      image: 'assets/raspberries.jpg',
    ),
    Product(
      name: 'Bananas',
      price: 0.64,
      unit: '/lb',
      farm: 'Lowry Farms',
      image: 'assets/bananas.jpg',
    ),
    Product(
      name: 'Avocados',
      price: 1.05,
      unit: 'each',
      farm: 'Gonzalez Produce',
      image: 'assets/avocados.jpg',
    ),
    Product(
      name: 'Kale',
      price: 1.99,
      unit: 'each',
      farm: 'Green Growers',
      image: 'assets/kale.jpg',
    ),
    Product(
      name: 'Radish',
      price: 1.29,
      unit: 'each',
      farm: 'Gonzalez Produce',
      image: 'assets/radish.jpg',
    ),
  ];

  List<Product> cartItems = [];
  List<Product> favoriteItems = [];

  void addToCart(Product product) {
    setState(() {
      cartItems.add(product);
    });
  }

  void toggleFavorite(Product product) {
    setState(() {
      if (favoriteItems.contains(product)) {
        favoriteItems.remove(product);
      } else {
        favoriteItems.add(product);
      }
    });
  }

  bool isFavorite(Product product) {
    return favoriteItems.contains(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('World Peas Market'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cartItems: cartItems),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Favorites(favoriteItems: favoriteItems),
                ),
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            onAddToCart: () => addToCart(product),
            onToggleFavorite: () => toggleFavorite(product),
            isFavorite: isFavorite(product),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback onToggleFavorite;
  final bool isFavorite;

  const ProductCard({super.key, 
    required this.product,
    required this.onAddToCart,
    required this.onToggleFavorite,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product.image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8.0),
            Text(
              product.name,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '\$${product.price} ${product.unit}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '${product.farm} →',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onAddToCart,
                  child: Text('Add to Cart'),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: onToggleFavorite,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Product> cartItems;

  const CartScreen({super.key, required this.cartItems});

  double get cartTotal {
    double total = 0;
    for (var item in cartItems) {
      total += item.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('Your cart is empty.'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Image.asset(
                                item.image,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('\$${item.price} ${item.unit}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: \$${cartTotal.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Text('Checkout pressed!');
                        },
                        child: Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class Favorites extends StatelessWidget {
  final List<Product> favoriteItems;

  const Favorites({super.key, required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: favoriteItems.isEmpty
          ? Center(child: Text('No favorites yet.'))
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Image.asset(
                          item.image,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('\$${item.price} ${item.unit}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}