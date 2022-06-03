import 'package:flutter/material.dart';
import 'package:seeds_system/routes.dart';
import '../widgets/seeds_widgets/menu_drawer.dart';
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
          foregroundColor: Colors.white,
          backgroundColor: Colors.green.shade400,
          actions: [],
          title: Container(
            width: double.infinity,
            height: 45,
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "Pesquisar",
                fillColor: Colors.white70,
                filled: true,
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ),
        drawer: const MenuDrawerWidget(),
        body: Stack(
          children: <Widget>[
            BlocBuilder<SeedsBloc, SeedsStates>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is LoadingSeedsState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SomeSeedsState) {
                    final seedsList = state.seeds;
                    return ListView.separated(
                      padding: const EdgeInsets.all(9),
                      itemCount: seedsList.length,
                      itemBuilder: (context, index) => Card(
                        elevation: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  onTap: () {
                                    // TODO: NAVIGATION TO DETAIL SCREEN
                                  },
                                  onLongPress: () {
                                    print("alo");
                                  },
                                  title: Text(seedsList[index].name),
                                  subtitle: Text(
                                      "Fabricante: ${seedsList[index].manufacturer.toString()}"),
                                  isThreeLine: true,
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete_forever),
                                    onPressed: () {
                                      bloc.add(
                                          DeleteSeedEvent(seedsList[index]));
                                    },
                                  ),
                                ),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(),
                                  onPressed: () {},
                                  label: const Text("Dado não sincronizado!"),
                                  icon: const Icon(Icons.sync_disabled_rounded),
                                )
                              ]),
                        ),
                      ),
                      separatorBuilder: (context, index) => const Divider(),
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
