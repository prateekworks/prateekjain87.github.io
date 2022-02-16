import 'package:flutter/material.dart';

import 'components/confirmbody.dart';

class ForgotPasswordScreenConfirm extends StatelessWidget {
  static String routeName = "/forgot_password_confirm";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter the Required Details!"),
      ),
      body: Body(),
    );
  }
}