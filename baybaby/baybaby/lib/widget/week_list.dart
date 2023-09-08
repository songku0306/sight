import 'package:flutter/material.dart';

class Product {
  final String name;
  final String sub;
  final String date;
  final IconData iconData; // IconData 추가

  Product({
    required this.name,
    required this.sub,
    required this.date,
    required this.iconData,
  });
}

class ShoppingApp extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'sleep : 7hrs \nfeed : 5 \ndiper : 5',
      sub: '',
      date: '9 / 8',
      iconData: Icons.home,
    ),
    Product(
      name: 'sleep : 7hrs \nfeed : 5 \ndiper : 5',
      sub: '',
      date: '9 / 7',
      iconData: Icons.flip_camera_android_outlined,
    ),
    Product(
      name: 'sleep : 7hrs \nfeed : 5 \ndiper : 5',
      sub: '',
      date: '9 / 6',
      iconData: Icons.home,
    ),
    Product(
      name: 'sleep : 7hrs \nfeed : 5 \ndiper : 5',
      sub: '',
      date: '9 / 5',
      iconData: Icons.flip_camera_android_outlined,
    ),
    // 다른 상품들을 추가할 수 있습니다.
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Mall',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ListTile(
              leading: Icon(
                product.iconData,
                size: 80,
                color: Colors.blue,
              ),
              title: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(product.name),
              ),
              subtitle: Text(product.sub),
              trailing: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  product.date,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                    fontSize: 30,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
