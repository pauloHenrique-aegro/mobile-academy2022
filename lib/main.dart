import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seeds_system/blocs/seeds_bloc/seeds_bloc.dart';
import 'ui/screens/splash_screen.dart';
import 'utils/routes.dart';
import './blocs/auth_bloc/auth_bloc.dart';
import './blocs/auth_bloc/auth_state.dart';
import './ui/screens/auth_screen.dart';
import './ui/screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(AuthLoginModeState())),
        BlocProvider(create: (context) => SeedsBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          appBarTheme: AppBarTheme.of(context).copyWith(
            elevation: 0,
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            titleTextStyle: const TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(AuthLoginModeState()),
          child: const SplashPage(),
        ),
        routes: {
          authScreenRoute: (ctx) => const AuthPage(),
          dashboardRoute: (ctx) => const DashboardPage(),
        },
      ),
    );
  }
}
