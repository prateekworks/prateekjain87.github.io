
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:async';

List<Product> demoProducts = [];
class Product {
  final int id;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;
  final String title, lister, description, nature, category, requirements, overview, street, landmark, district, state, country;
  final double payscale;
  final DateTime? datePosted, dateExpiry;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    required this.price,
    required this.title,
    required this.lister,
    required this.description,
    required this.nature,
    required this.payscale,
    required this.dateExpiry,
    required this.datePosted,
    required this.category,
    required this.requirements,
    required this.overview,
    required this.street,
    required this.landmark,
    required this.district,
    required this.state,
    required this.country,
    this.isFavourite = true,
    this.isPopular = true,
  });
}

// Our demo Products
gigDetails() async {
  demoProducts = [];
  print("In Gig");
  var url = Uri.parse("http://192.168.0.109:3000/api/getGigs");
  final http.Response response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{

    }),
  );

  if (response.statusCode == 200) {
    print("in reponse");
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    //print(response.body);
    final decoded = json.decode(response.body);
    decoded.forEach((gig) =>
    demoProducts.add(Product(id: int.parse(gig["gigid"]), images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ], colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
        price: double.parse(gig["payscale"]),
        title: gig["title"],
        lister: gig["lister"],
        description: gig["description"],
        nature: gig["nature"],
        payscale: double.parse(gig["payscale"]),
        dateExpiry: DateTime.tryParse(gig["dateExpiry"]),
        datePosted: DateTime.tryParse(gig["datePosted"]),
        category: gig["category"],
        requirements: gig["requirements"],
        overview: gig["overview"],
        street: gig["address"][0]["street"],
        landmark: gig["address"][0]["landmark"],
        district: gig["address"][0]["district"],
        state: gig["address"][0]["state"],
        country: gig["address"][0]["country"]))
    );
  } else {
    throw Exception('Failed to create album.');
  }
  print(demoProducts.length);
}

/*  Product(
    id: 1,
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Nike Sport White - Man Pant",
    price: pro.price,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: 3,
    images: [
      "assets/images/glap.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Gloves XC Omega - Polygon",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 4,
    images: [
      "assets/images/wireless headset.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Logitech Head",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
];*/

const String description =
    "Branded Kachcha PS4™ gives you what you want in your gaming from over precision control your games to sharing …";

