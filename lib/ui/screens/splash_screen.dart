import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seeds_system/routes.dart';
import 'package:seeds_system/utils/userId_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool loggedIn = true;
  isLogged() async {
    loggedIn = await UserPreferences().containsIdKey();
  }

  @override
  void initState() {
    super.initState();
    isLogged();

    Timer(const Duration(seconds: 1), () {
      loggedIn
          ? Navigator.of(context).pushReplacementNamed(dashboardRoute)
          : Navigator.of(context).pushReplacementNamed(authScreenRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(0, 140, 49, 1).withOpacity(0.9),
      child: Image.asset('assets/images/logo.png'),
    );
  }
}
