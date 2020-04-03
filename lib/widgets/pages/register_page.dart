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
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  final FocusNode _passwordNode = FocusNode();
  final FocusNode _passwordConfirmNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _registerFormBloc = BlocProvider.of<RegisterFormBloc>(context);
  }

  void _attemptRegister() {
    _registerFormBloc.add(
      RegisterAttempt(
        email: _emailController.text,
        password: _passwordController.text,
        passwordConfirm: _passwordConfirmController.text,
      ),
    );

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocListener<RegisterFormBloc, RegisterFormState>(
          bloc: _registerFormBloc,
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
            if (state.registered) {
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
                            errorText: state.emailError,
                          ),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(_passwordConfirmNode);
                          },
                          decoration: InputDecoration(
                            labelText: "Password",
                            errorText: state.passwordError,
                          ),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        TextFormField(
                          controller: _passwordConfirmController,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: _attemptRegister,
                          decoration: InputDecoration(
                            labelText: "Confirm password",
                            errorText: state.passwordConfirmError,
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
                        state.submitting
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                onPressed: _attemptRegister,
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
    _passwordConfirmController.dispose();

    _passwordNode.dispose();
    _passwordConfirmNode.dispose();

    super.dispose();
  }
}
