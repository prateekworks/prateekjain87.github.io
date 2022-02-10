import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
int itemCount = 10;
class Domestic extends StatelessWidget {
  static String routeName = "/domestic";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Empty List Test')),
      body: itemCount > 0
          ? ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Item ${index + 1}'),
          );
        },
      )
          : const Center(child: Text('No items')),
    );
  }
}
