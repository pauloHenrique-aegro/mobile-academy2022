import 'package:flutter/material.dart';
import '../widgets/auth_widgets/auth_card.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: const Color.fromRGBO(0, 140, 49, 1).withOpacity(0.9),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: screenSize.height,
              width: screenSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Seja bem vindo(a)',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Text(
                        'Faça o seu login para continuar.',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                  Flexible(
                    flex: screenSize.width > 600 ? 2 : 1,
                    child: const AuthCardWidget(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
