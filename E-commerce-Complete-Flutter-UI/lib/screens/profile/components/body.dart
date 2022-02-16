

import 'package:flutter/material.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/sign_in/components/sign_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              logoutUser(context);
            },
          ),
        ],
      ),
    );
  }
}

Future<void> logoutUser(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SplashScreen()),);
    Navigator.of(context)
    .pushNamedAndRemoveUntil(SplashScreen.routeName, (Route<dynamic> route) => false);
} 