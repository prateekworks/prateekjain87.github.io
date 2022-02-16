/*import 'package:flutter/material.dart';
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
    child:SafeArea(
        child: FutureBuilder(
          future: Future.wait([gigDetails()]),
          builder: (BuildContext context, snapshot) {
            child:
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return CircularProgressIndicator();
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                if (snapshot.hasError) {
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
                          onPressed: () {},
                        )
                      ],
                    ),
                  );
                }
                return SingleChildScrollView(
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
              default:
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
                        onPressed: () {},
                      )
                    ],
                  ),
                );
            /* if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
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
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("Waiting");
              return Center(
                child: CircularProgressIndicator(),
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
            else {
              return Center(
                child: CircularProgressIndicator(),
              );
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
                      onPressed: () {},
                    )
                  ],
                ),
              );*/
            }
          },
        )
    );
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.sentiment_dissatisfied),
          Text("Something went wrong"),
          FlatButton(
            child: Text("Retry"),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
*/