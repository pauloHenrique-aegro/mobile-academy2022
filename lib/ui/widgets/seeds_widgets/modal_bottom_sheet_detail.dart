import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:seeds_system/database/seeds_database_model.dart';
import 'package:seeds_system/ui/widgets/show_dialogs.dart';
import '../../../routes.dart';
import '../../../blocs/seeds_bloc/seeds_bloc.dart';
import '../../../blocs/seeds_bloc/seeds_state.dart';
import '../../../blocs/seeds_bloc/seeds_event.dart';

class SeedDetail extends StatefulWidget {
  final SeedsDatabaseModel seed;
  final String name;
  final String manufacturer;
  final String manufacturedAt;
  final String expiresIn;
  const SeedDetail(
      {required this.name,
      required this.manufacturer,
      required this.manufacturedAt,
      required this.expiresIn,
      required this.seed,
      Key? key})
      : super(key: key);

  @override
  State<SeedDetail> createState() => _SeedDetailState();
}

class _SeedDetailState extends State<SeedDetail> {
  TextEditingController nameController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();
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
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.green.shade200,
      child: BlocBuilder<SeedsBloc, SeedsStates>(
          bloc: bloc,
          builder: (context, state) {
            return Column(children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: widget.name),
                    ),
                    TextFormField(
                      controller: manufacturerController,
                      decoration:
                          InputDecoration(labelText: widget.manufacturer),
                    ),
                    SizedBox(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _manufacturedAt == null
                                  ? widget.manufacturedAt
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
                                  ? widget.expiresIn
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
                          bloc.add(UpdateSeedEvent(SeedsDatabaseModel(
                              id: widget.seed.id,
                              name: nameController.text,
                              manufacturer: manufacturerController.text,
                              manufacturedAt: _manufacturedAt!.toString(),
                              expiresIn: _manufacturedAt!.toString(),
                              createdAt: widget.seed.createdAt,
                              createdBy: widget.seed.createdBy,
                              isSync: widget.seed.isSync)));
                          Navigator.of(context)
                              .pushReplacementNamed(dashboardRoute);
                        },
                        child: const Text("Atualizar")),
                  ],
                ),
              ),
              Row(children: [
                SizedBox(
                  width: screenSize.width * 0.5,
                  child: ElevatedButton(
                      onPressed: () {
                        showAlertDialog(
                            context,
                            bloc.add(SyncSeedEvent(widget.seed)),
                            dashboardRoute);
                      },
                      child: const Text("Sincronizar")),
                ),
                SizedBox(
                  width: screenSize.width * 0.5,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        bloc.add(DeleteSeedEvent(widget.seed));
                        Navigator.of(context)
                            .pushReplacementNamed(dashboardRoute);
                      },
                      child: const Text("Deletar")),
                ),
              ]),
            ]);
          }),
    );
  }
}
