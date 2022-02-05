import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';
import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: gigDetails(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
            child:
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(20)),
                  HomeHeader(),
                  SizedBox(height: getProportionateScreenWidth(10)),
                  DiscountBanner(),
                  Categories(),
                  SpecialOffers(),
                  SizedBox(height: getProportionateScreenWidth(30)),
                  PopularProducts(),
                  SizedBox(height: getProportionateScreenWidth(30)),
                ],
              ),
            );
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return (snapshot.data);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError &&
                snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.sentiment_dissatisfied),
                    Text("Something went wrong ${snapshot.error}"),
                    FlatButton(
                      child: Text("Retry"),
                      onPressed: ,
                    )
                  ],
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.sentiment_neutral),
                    Text("Waiting on things to start...")
                  ],
                ),
              );
            }
            return Container();
        },
    );
  }
}
