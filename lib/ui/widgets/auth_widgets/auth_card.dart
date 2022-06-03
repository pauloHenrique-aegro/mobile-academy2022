import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seeds_system/models/api_exception.dart';
import 'package:seeds_system/routes.dart';
import '../../../blocs/auth_bloc/auth_event.dart';
import '../show_error_dialog.dart';
import '../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../blocs/auth_bloc/auth_state.dart';

class AuthCardWidget extends StatefulWidget {
  const AuthCardWidget({Key? key}) : super(key: key);

  @override
  State<AuthCardWidget> createState() => _AuthCardWidgetState();
}

class _AuthCardWidgetState extends State<AuthCardWidget> {
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
        bloc: bloc,
        builder: (context, state) {
          return Container(
            height: state is AuthSignUpModeState ? 280 : 220,
            width: screenSize.width * 0.75,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                if (state is AuthSignUpModeState)
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
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) async {
                    if (state is AuthFailureState) {
                      if (state.exception is UserNotFound) {
                        await showErrorDialog(
                            context, 'Usuário não encontrado!');
                      } else if (state.exception is InvalidFields) {
                        await showErrorDialog(
                            context, "Por favor, verifique os campos!");
                      } else if (state.exception is EmailInUse) {
                        await showErrorDialog(context, 'Email já cadastrado!');
                      } else {
                        await showErrorDialog(context,
                            "Ocorreu um erro. Tente novamente mais tarde!");
                      }
                    }
                    if (state is LoginSucessState) {
                      Navigator.of(context)
                          .pushReplacementNamed(dashboardRoute);
                    }
                  },
                  child: state is LoadingAuthState
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text(state is AuthSignUpModeState
                              ? 'CRIAR CONTA'
                              : 'ENTRAR'),
                          onPressed: () async {
                            state is AuthSignUpModeState
                                ? bloc.add(SignUpButtonPressed(
                                    fullName: name.text, email: email.text))
                                : bloc
                                    .add(LoginButtonPressed(email: email.text));
                          },
                        ),
                ),
                TextButton(
                  child: Text(state is AuthSignUpModeState
                      ? 'Já possui cadastro? Entrar'
                      : 'Não possui conta? Cadastre-se'),
                  onPressed: () {
                    bloc.add(SwitchAuthModeEvent());
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    name.dispose();
    super.dispose();
  }
}
