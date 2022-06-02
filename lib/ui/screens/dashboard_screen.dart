import 'package:flutter/material.dart';
import 'package:seeds_system/database/seeds_database_model.dart';
import 'package:seeds_system/routes.dart';
import '../../blocs/seeds_bloc/seeds_bloc.dart';
import '../../blocs/seeds_bloc/seeds_event.dart';
import '../../blocs/seeds_bloc/seeds_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final SeedsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = SeedsBloc();
    bloc.add(LoadSeedsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add_box,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(postSeedsRoute);
              },
            ),
          ],
          title: Container(
            width: double.infinity,
            height: 45,
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Pesquisar",
                fillColor: Colors.white,
                filled: true,
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const SizedBox(
                height: 100,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 140, 49, 1),
                  ),
                  child: Text('Seja bem vindo, Nome do usuário!'),
                ),
              ),
              ListTile(
                title: const Text('Sementes'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Sincronizar'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(255, 255, 255, 255).withOpacity(0.5),
                    const Color.fromRGBO(0, 140, 49, 1).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, 1],
                ),
              ),
            ),
            BlocBuilder<SeedsBloc, SeedsStates>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is EmptySeedsState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SomeSeedsState) {
                    final seedsList = state.seeds;
                    return ListView.separated(
                      itemCount: seedsList.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(seedsList[index].name),
                        subtitle: Text(
                            "Dias para germinação: ${seedsList[index].manufacturer.toString()}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            bloc.add(DeleteSeedEvent(seedsList[index]));
                          },
                        ),
                      ),
                      separatorBuilder: (_, __) => const Divider(),
                    );
                  }
                  return Container();
                }),
          ],
        ));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
