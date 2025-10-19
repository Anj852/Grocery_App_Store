import 'package:flutter/material.dart';
import 'package:my_grocery/app_drawer.dart';

class CartItem {
  String name;
  double price;
  int quantity;

  CartItem({required this.name, required this.price, this.quantity = 1});
}

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartItem> cartItems = []; 
  @override
  void initState() {
    super.initState();
    cartItems = [
      CartItem(name: 'Garlic clove', price: 0.89),
      CartItem(name: 'Sugar snap pea', price: 2.29),
      CartItem(name: 'Ginger', price: 4.20),
      CartItem(name: 'Sweet onion', price: 0.39),
      CartItem(name: 'Raspberries', price: 3.99),
      CartItem(name: 'Bananas', price: 0.64),
      CartItem(name: 'Avocados', price: 1.05),
      CartItem(name: 'Kale', price: 1.99),
      CartItem(name: 'Radish', price: 1.29),
    ];
  }

  double get cartTotal {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      drawer: AppDrawer(),
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
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text('Price: \$${item.price.toStringAsFixed(2)}'),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () => decreaseQuantity(index),
                                  ),
                                  Text('${item.quantity}'),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () => increaseQuantity(index),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => removeItem(index),
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
                            fontSize: 20, fontWeight: FontWeight.bold),
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