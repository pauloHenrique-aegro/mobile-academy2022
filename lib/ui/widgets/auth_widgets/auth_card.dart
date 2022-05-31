import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seeds_system/blocs/auth_bloc/auth_event.dart';
import '../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../blocs/auth_bloc/auth_state.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  late final AuthBloc bloc;

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    bloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: BlocBuilder<AuthBloc, AuthState>(
          bloc: BlocProvider.of<AuthBloc>(context),
          builder: (context, state) {
            return Container(
              height: state is AuthSignUpState ? 280 : 220,
              width: screenSize.width * 0.75,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  if (state is AuthSignUpState)
                    TextFormField(
                        controller: name,
                        decoration: const InputDecoration(labelText: 'Nome'),
                        onSaved: (value) {}),
                  TextFormField(
                      controller: email,
                      decoration: const InputDecoration(labelText: 'E-mail'),
                      onSaved: (value) {}),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text(
                        state is AuthSignUpState ? 'CRIAR CONTA' : 'ENTRAR'),
                    onPressed: () {
                      state is AuthSignUpState
                          ? bloc.add(SignUpButtonPressed(
                              fullName: name.text, email: email.text))
                          : bloc.add(LoginButtonPressed(email: email.text));
                    },
                  ),
                  TextButton(
                    child: Text(state is AuthSignUpState
                        ? 'Já possui cadastro? Entrar'
                        : 'Não possui conta? Cadastre-se'),
                    onPressed: () {
                      bloc.add(SwitchAuthModeEvent());
                    },
                  )
                ],
              ),
            );
          }),
    );
  }
}
