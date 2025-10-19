import 'package:flutter/material.dart';
import 'package:my_grocery/app_drawer.dart';

class Newsstand extends StatefulWidget {
  const Newsstand({super.key});

  @override
  State<Newsstand> createState() => _NewsstandState();
}

class _NewsstandState extends State<Newsstand> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Grocery'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add_shopping_cart)),
        ],
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 20),
                Expanded(child: Text('Newsstand')),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('< Back>'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
