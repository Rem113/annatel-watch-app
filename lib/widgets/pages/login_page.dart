import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/login/login_bloc.dart';
import '../../routes.dart';
import '../controls/gradient_flat_button.dart';
import '../controls/gradient_raised_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _passwordNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _loginBloc = BlocProvider.of<LoginBloc>(context);

    _emailController.addListener(_onEmailInput);
    _passwordController.addListener(_onPasswordInput);
  }

  void _onEmailInput() {
    _loginBloc.add(
      EmailChanged(
        email: _emailController.text,
      ),
    );
  }

  void _onPasswordInput() {
    _loginBloc.add(
      PasswordChanged(
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          bloc: BlocProvider.of<LoginBloc>(context),
          listener: (context, state) {
            if (state.success) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "You are logged in",
                      style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.title.fontFamily,
                      ),
                    ),
                    Icon(Icons.done),
                  ],
                ),
                backgroundColor: Colors.green,
              ));
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
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
                          style: Theme.of(context).textTheme.title,
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
                            errorText: state.shouldValidateEmail &&
                                    state.emailError.isNotEmpty
                                ? state.emailError
                                : null,
                          ),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            errorText: state.shouldValidatePassword &&
                                    state.passwordError.isNotEmpty
                                ? state.passwordError
                                : null,
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
                            Navigator.of(context).pushNamed(REGISTER_PAGE);
                          },
                          text: "I don't have an account",
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
                          onPressed: () {
                            _loginBloc.add(
                              FormSubmitted(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          },
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

    super.dispose();
  }
}
