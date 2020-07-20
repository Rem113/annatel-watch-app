import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/login_form/login_form_bloc.dart';
import '../../routes.dart';
import '../controls/gradient_flat_button.dart';
import '../controls/gradient_raised_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginFormBloc _loginFormBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _passwordNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _loginFormBloc = BlocProvider.of<LoginFormBloc>(context);
  }

  void _attemptLogin() {
    _loginFormBloc.add(
      LoginAttempt(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocListener<LoginFormBloc, LoginFormState>(
          bloc: BlocProvider.of<LoginFormBloc>(context),
          listener: (context, state) {
            if (state.serverError != null) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          state.serverError,
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .headline6
                                .fontFamily,
                          ),
                        ),
                        Icon(Icons.done),
                      ],
                    ),
                    backgroundColor: Theme.of(context).errorColor,
                  ),
                );
            }
            if (state.loggedIn) {
              Navigator.of(context).pushReplacementNamed(SUBSCRIPTION_PAGE);
            }
          },
          child: BlocBuilder<LoginFormBloc, LoginFormState>(
            builder: (context, state) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
              ),
              child: Form(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(_passwordNode);
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            errorText: state.emailError,
                          ),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: _attemptLogin,
                          decoration: InputDecoration(
                            labelText: "Password",
                            errorText: state.passwordError,
                          ),
                          focusNode: _passwordNode,
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
                            Navigator.of(context)
                                .pushReplacementNamed(REGISTER_PAGE);
                          },
                          text: "I don't have an account",
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        state.submitting
                            ? Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              )
                            : GradientRaisedButton(
                                borderRadius: 8.0,
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context).accentColor,
                                  ],
                                ),
                                onPressed: _attemptLogin,
                                text: "Login",
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _passwordNode.dispose();

    super.dispose();
  }
}
