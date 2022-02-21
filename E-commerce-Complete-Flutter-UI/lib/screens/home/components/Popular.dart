import 'package:flutter/material.dart';
import 'package:shop_app/components/category_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/components/product_card.dart';

int item = 3;
class Popular extends StatelessWidget {
  static String routeName = "/popular";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Empty List Test')),
      body: item > 0
          ? ListView.builder(
        itemCount: item,
        itemBuilder: (context, position) {
          return CategoryCard(product: demoProducts[item-1]);
          // return Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(25.0),
          //     child: Text(position.toString(), style: TextStyle(fontSize: 22.0),),
          //   ),
          //);
        },
      )
          : const Center(child: Text('No items')),
    );
  }
}
