import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/login/login_bloc.dart';
import 'blocs/register/register_bloc.dart';
import 'routes.dart';
import 'widgets/pages/login_page.dart';
import 'widgets/pages/map_page.dart';
import 'widgets/pages/register_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xFF8E54E9),
          accentColor: Color(0xFF4776E6),
          fontFamily: 'Quicksand',
          textTheme: TextTheme(
            title: TextStyle(
              fontSize: 48.0,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(),
            labelStyle: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        initialRoute: LOGIN_PAGE,
        routes: {
          LOGIN_PAGE: (ctx) => BlocProvider<LoginBloc>(
                create: (_) => LoginBloc(),
                child: LoginPage(),
              ),
          REGISTER_PAGE: (ctx) => BlocProvider<RegisterBloc>(
                create: (_) => RegisterBloc(),
                child: RegisterPage(),
              ),
          MAP_PAGE: (ctx) => MapPage(),
        },
      );
}
