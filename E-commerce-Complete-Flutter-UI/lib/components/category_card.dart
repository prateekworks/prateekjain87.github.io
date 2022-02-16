import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'dart:math';
import '../constants.dart';
import '../size_config.dart';
Random random = new Random();

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    this.width = 150,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(10)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: product),
          ),
       // child: Column(mainAxisSize: MainAxisSize.min,children:[
        //new Container(
        //padding: new EdgeInsets.only(top: 15.0),
          child: Row(mainAxisSize: MainAxisSize.max,children:[
            new Container(
                padding: new EdgeInsets.only(top: 10.0),
            //crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //children: [
            child:
              Row(
                children: [
                  new Container(
                    width: width,
                  padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Hero(
                    tag: random.nextInt(100).toString(),
                    child: Image.asset(product.images[0]),
                  ),

                ),
                  SizedBox(width: 10),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 15),
                    Text("This is sample text to check ",
                      //product.title,
                      style: TextStyle(color: Colors.black),
                      maxLines: 2,
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "\$${product.price}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                          ),
                        ),
                        SizedBox(width: 120),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(getProportionateScreenWidth(7)),
                            height: getProportionateScreenWidth(28),
                            width: getProportionateScreenWidth(28),
                            //alignment: Alignment.bottomRight,
                            decoration: BoxDecoration(
                              color: product.isFavourite
                                  ? kPrimaryColor.withOpacity(0.15)
                                  : kSecondaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,

                            ),
                            child: SvgPicture.asset(
                              "assets/icons/Heart Icon_2.svg",
                              color: product.isFavourite
                                  ? Color(0xFFFF4848)
                                  : Color(0xFFDBDEE4),
                            ),
                          ),
                        )],),
                    Column(
                        children:[
                          SizedBox(height: 30)
                        ]
                    )
                  ],
              )]
              ),

          ),
        ]),
        ),
      ));
    //)
   // )
    //);
  }
}
