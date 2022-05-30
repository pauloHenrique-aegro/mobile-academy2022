import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return MaterialApp(
      title: 'Sementes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme.of(context).copyWith(
          elevation: 0,
          backgroundColor: Colors.green,
          foregroundColor: Colors.black,
          titleTextStyle: const TextStyle(
            fontSize: 26,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: BlocProvider<AuthBloc>(
        create: (BuildContext context) => AuthBloc(AuthLoginState()),
        child: const AuthPage(),
      ),
      routes: {
        DashboardPage.routeName: (ctx) => const DashboardPage(),
      },
    );
  }
}
