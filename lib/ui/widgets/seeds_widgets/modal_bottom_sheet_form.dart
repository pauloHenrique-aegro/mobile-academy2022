import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../routes.dart';
import '../../../blocs/seeds_bloc/seeds_bloc.dart';
import '../../../blocs/seeds_bloc/seeds_state.dart';
import '../../../blocs/seeds_bloc/seeds_event.dart';
import '../../../models/seeds.dart';

class PostSeeds extends StatefulWidget {
  const PostSeeds({Key? key}) : super(key: key);

  @override
  State<PostSeeds> createState() => _PostSeedsState();
}

class _PostSeedsState extends State<PostSeeds> {
  TextEditingController name = TextEditingController();
  TextEditingController manufacturer = TextEditingController();
  DateTime? _manufacturedAt;
  DateTime? _expiresIn;
  final applicationDateFormat = DateFormat('dd-MM-yyyy');

  void _manufacturedAtDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    ).then((manufacturedAtPickedDate) {
      if (manufacturedAtPickedDate == null) {
        return;
      }
      setState(() {
        _manufacturedAt = manufacturedAtPickedDate;
      });
    });
  }

  void _expiresInDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _manufacturedAt!.add(const Duration(days: 1)),
      firstDate: _manufacturedAt!.add(const Duration(days: 1)),
      lastDate: DateTime(DateTime.now().year + 5),
    ).then((expiresInPickedDate) {
      if (expiresInPickedDate == null) {
        return;
      }
      setState(() {
        _expiresIn = expiresInPickedDate;
      });
    });
  }

  late final SeedsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = SeedsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade200,
      child: BlocBuilder<SeedsBloc, SeedsStates>(
          bloc: bloc,
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: name,
                    decoration:
                        const InputDecoration(labelText: "Nome da semente"),
                  ),
                  TextFormField(
                    controller: manufacturer,
                    decoration: const InputDecoration(labelText: "Fabricante"),
                  ),
                  SizedBox(
                    height: 70,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _manufacturedAt == null
                                ? 'Data de Fabricação'
                                : 'Data de Fabricação: ${applicationDateFormat.format(_manufacturedAt!)}',
                          ),
                        ),
                        OutlinedButton(
                          child: const Text(
                            'Insira a data',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _manufacturedAtDatePicker,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _expiresIn == null
                                ? 'Data de vencimento'
                                : 'Data de vencimento: ${applicationDateFormat.format(_expiresIn!)}',
                          ),
                        ),
                        OutlinedButton(
                          child: const Text(
                            'Insira a data',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _manufacturedAt == null
                              ? null
                              : _expiresInDatePicker,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        bloc.add(RegisterSeedEvent(Seeds(
                            name: name.text,
                            manufacturer: manufacturer.text,
                            manufacturedAt: _manufacturedAt!,
                            expiresIn: _expiresIn!)));
                        Navigator.of(context)
                            .pushReplacementNamed(dashboardRoute);
                      },
                      child: const Text("Cadastrar"))
                ],
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
