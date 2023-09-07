import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final IconData iconData; // IconData 추가

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.iconData,
  });
}

class ShoppingApp extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: '상품 1',
      description: '상품 1의 상세 설명입니다.',
      price: 29.99,
      iconData: Icons.home,
    ),
    Product(
      name: '상품 2',
      description: '상품 2의 상세 설명입니다.',
      price: 19.99,
      iconData: Icons.search,
    ),
    Product(
      name: '상품 1',
      description: '상품 1의 상세 설명입니다.',
      price: 29.99,
      iconData: Icons.home,
    ),
    Product(
      name: '상품 2',
      description: '상품 2의 상세 설명입니다.',
      price: 19.99,
      iconData: Icons.search,
    ),
    Product(
      name: '상품 1',
      description: '상품 1의 상세 설명입니다.',
      price: 29.99,
      iconData: Icons.home,
    ),
    Product(
      name: '상품 2',
      description: '상품 2의 상세 설명입니다.',
      price: 19.99,
      iconData: Icons.search,
    ),
    Product(
      name: '상품 1',
      description: '상품 1의 상세 설명입니다.',
      price: 29.99,
      iconData: Icons.home,
    ),
    Product(
      name: '상품 2',
      description: '상품 2의 상세 설명입니다.',
      price: 19.99,
      iconData: Icons.search,
    ),
    Product(
      name: '상품 1',
      description: '상품 1의 상세 설명입니다.',
      price: 29.99,
      iconData: Icons.home,
    ),
    Product(
      name: '상품 2',
      description: '상품 2의 상세 설명입니다.',
      price: 19.99,
      iconData: Icons.search,
    ),
    Product(
      name: '상품 1',
      description: '상품 1의 상세 설명입니다.',
      price: 29.99,
      iconData: Icons.home,
    ),
    Product(
      name: '상품 2',
      description: '상품 2의 상세 설명입니다.',
      price: 19.99,
      iconData: Icons.search,
    ),
    Product(
      name: '상품 1',
      description: '상품 1의 상세 설명입니다.',
      price: 29.99,
      iconData: Icons.home,
    ),
    Product(
      name: '상품 2',
      description: '상품 2의 상세 설명입니다.',
      price: 19.99,
      iconData: Icons.search,
    ),
    Product(
      name: '상품 1',
      description: '상품 1의 상세 설명입니다.',
      price: 29.99,
      iconData: Icons.home,
    ),
    Product(
      name: '상품 2',
      description: '상품 2의 상세 설명입니다.',
      price: 19.99,
      iconData: Icons.search,
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
              title: Text(product.name),
              subtitle: Text(product.description),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // 구매 버튼을 눌렀을 때 동작
                    },
                    child: Text('구매'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
