import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/home/components/CategorySelection.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/screens/home/components/art_category.dart';
import 'package:shop_app/screens/home/components/domestic_category.dart';
import 'package:shop_app/screens/home/components/events_category.dart';
import 'package:shop_app/screens/home/components/dailywage_category.dart';
import 'package:shop_app/screens/home/components/misc_category.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'package:shop_app/screens/home/components/art_category.dart';
import 'package:shop_app/screens/home/components/Popular.dart';
import 'package:shop_app/screens/home/components/Special.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  Special.routeName: (context) => Special(),
  Popular.routeName: (context) => Popular(),
  SplashScreen.routeName: (context) => SplashScreen(),
  Art.routeName: (context) => Art(),
  CategorySelection.routeName: (context) => CategorySelection(),
  Domestic.routeName: (context) => Domestic(),
  Events.routeName: (context) => Events(),
  DailyWage.routeName: (context) => DailyWage(),
  Misc.routeName: (context) => Misc(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
};
