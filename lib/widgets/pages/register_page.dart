import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/register_form/register_form_bloc.dart';
import '../../routes.dart';
import '../controls/gradient_flat_button.dart';
import '../controls/gradient_raised_button.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterFormBloc _registerFormBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _passwordNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _registerFormBloc = BlocProvider.of<RegisterFormBloc>(context);

    _emailController.addListener(_onEmailInput);
    _passwordController.addListener(_onPasswordInput);
  }

  void _onEmailInput() {
    _registerFormBloc.add(
      EmailChanged(
        email: _emailController.text,
      ),
    );
  }

  void _onPasswordInput() {
    _registerFormBloc.add(
      PasswordChanged(
        password: _passwordController.text,
      ),
    );
  }

  void showSnackBar(BuildContext context, SnackBar snackBar) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocListener<RegisterFormBloc, RegisterFormState>(
          bloc: _registerFormBloc,
          listener: (context, state) {
            if (state.submitting) {
              showSnackBar(
                context,
                SnackBar(
                  backgroundColor: Theme.of(context).accentColor,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Attempting to register...",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.title.fontFamily,
                        ),
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            }
            if (state.error) {
              showSnackBar(
                context,
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "An error has occured",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.title.fontFamily,
                        ),
                      ),
                      Icon(Icons.done),
                    ],
                  ),
                  backgroundColor: Theme.of(context).errorColor,
                ),
              );
            }
            if (state.success) {
              Navigator.of(context).pushReplacementNamed(LOGIN_PAGE);
            }
          },
          child: BlocBuilder<RegisterFormBloc, RegisterFormState>(
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
                          "Register",
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
                          onPressed: () {
                            _registerFormBloc.add(
                              RegisterAttempt(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          },
                          text: "Register",
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
