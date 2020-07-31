import 'package:annatel_app/blocs/watch/watch_bloc.dart';
import 'package:annatel_app/widgets/pages/locations_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/login_form/login_form_bloc.dart';
import 'blocs/register_form/register_form_bloc.dart';
import 'blocs/subscription/subscription_bloc.dart';
import 'routes.dart';
import 'widgets/pages/login_page.dart';
import 'widgets/pages/map_page.dart';
import 'widgets/pages/register_page.dart';
import 'widgets/pages/subscription_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider<SubscriptionBloc>(
        create: (_) => SubscriptionBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Color(0xFF8E54E9),
            accentColor: Color(0xFF4776E6),
            fontFamily: 'Quicksand',
            textTheme: TextTheme(
              headline6: TextStyle(
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
            LOGIN_PAGE: (ctx) => BlocProvider<LoginFormBloc>(
                  create: (_) => LoginFormBloc(),
                  child: LoginPage(),
                ),
            REGISTER_PAGE: (ctx) => BlocProvider<RegisterFormBloc>(
                  create: (_) => RegisterFormBloc(),
                  child: RegisterPage(),
                ),
            SUBSCRIPTION_PAGE: (ctx) => SubscriptionPage(),
            MAP_PAGE: (ctx) => BlocProvider<WatchBloc>(
                  create: (_) => WatchBloc(),
                  child: MapPage(),
                ),
            LOCATIONS_PAGE: (ctx) => LocationPage(),
          },
        ),
      );
}
