import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class fab extends StatelessWidget {
   @override
  Widget build(BuildContext context) => new Scaffold(
    floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.camera, color: Colors.white, size: 29,),
        backgroundColor: Colors.black,
        tooltip: 'Capture Picture',
        elevation: 5,
        splashColor: Colors.grey,
    ),
  );

}
