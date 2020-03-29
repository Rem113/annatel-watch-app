import 'package:annatel_app/widgets/controls/gradient_flat_button.dart';
import 'package:annatel_app/widgets/controls/gradient_raised_button.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 32.0,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                GradientFlatButton(
                  borderRadius: 8.0,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      LOGIN_PAGE,
                      (_) => false,
                    );
                  },
                  text: "I already have an account",
                ),
                SizedBox(
                  height: 16.0,
                ),
                GradientRaisedButton(
                  borderRadius: 8.0,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                  ),
                  onPressed: () {},
                  text: "Register",
                ),
              ],
            ),
          ),
        ),
      );
}
