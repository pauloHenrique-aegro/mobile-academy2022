import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seeds_system/database/seeds_database_model.dart';
import 'package:seeds_system/ui/widgets/seeds_widgets/modal_bottom_sheet_detail.dart';
import 'package:seeds_system/ui/widgets/seeds_widgets/show_modal_bottom.dart';
import '../../routes.dart';
import '../widgets/seeds_widgets/menu_drawer.dart';
import '../../blocs/seeds_bloc/seeds_bloc.dart';
import '../../blocs/seeds_bloc/seeds_event.dart';
import '../../blocs/seeds_bloc/seeds_state.dart';
import '../widgets/seeds_widgets/modal_bottom_sheet_form.dart';

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
    bloc.add(LoadApiSeedsEvent());
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
              onChanged: (text) => bloc.add(LoadSearchEvent(query: text)),
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
        floatingActionButton: FloatingActionButton(
            onPressed: () => showModalBottom(context, const PostSeeds()),
            child: const Icon(Icons.add)),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                    var seedsList = state.seeds;
                    return ListView.separated(
                      padding: const EdgeInsets.all(9),
                      itemCount: seedsList.length,
                      itemBuilder: (context, index) => Card(
                        elevation: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  onTap: () {
                                    showModalBottom(
                                        context,
                                        SeedDetail(
                                          name: seedsList[index].name,
                                          manufacturer:
                                              seedsList[index].manufacturer,
                                          manufacturedAt:
                                              seedsList[index].manufacturedAt,
                                          expiresIn: seedsList[index].expiresIn,
                                          seed: seedsList[index],
                                        ));
                                  },
                                  onLongPress: () {
                                    print("alo");
                                  },
                                  title: Text(seedsList[index].name),
                                  subtitle: Text(
                                      "Fabricante: ${seedsList[index].manufacturer.toString()}"),
                                  isThreeLine: true,
                                ),
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
    bloc.seedsController.close();
    bloc.close();
    super.dispose();
  }
}
