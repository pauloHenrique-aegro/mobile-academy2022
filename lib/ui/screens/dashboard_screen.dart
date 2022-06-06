import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../widgets/seeds_widgets/modal_bottom_sheet_detail.dart';
import '../widgets/seeds_widgets/show_modal_bottom.dart';
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
  final applicationDateFormat = DateFormat('dd.MM.yyyy hh:mm:ss');

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
        backgroundColor:
            const Color.fromRGBO(220, 220, 220, 1).withOpacity(0.9),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.green.shade400,
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
                      padding: const EdgeInsets.all(10),
                      itemCount: seedsList.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          showModalBottom(
                              context,
                              SeedDetail(
                                name: seedsList[index].name,
                                manufacturer: seedsList[index].manufacturer,
                                manufacturedAt: seedsList[index].manufacturedAt,
                                expiresIn: seedsList[index].expiresIn,
                                seed: seedsList[index],
                              ));
                        },
                        child: Card(
                          elevation: 8,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        seedsList[index].name,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Fabricante:'),
                                            Text(seedsList[index].manufacturer)
                                          ]),
                                      const SizedBox(height: 10),
                                      Container(
                                        height: 10,
                                        width: double.infinity,
                                        color: Colors.green.shade400,
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Data de Fabricação:'),
                                            Text(
                                              seedsList[index].manufacturedAt,
                                              style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor: Colors.green,
                                                  decorationThickness: 3),
                                            )
                                          ]),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Data de Fabricação:'),
                                          Text(
                                            seedsList[index].manufacturedAt,
                                            style: const TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: Colors.red,
                                                decorationThickness: 3),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ]),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                width: double.infinity,
                                color: Colors.green.shade200,
                                alignment: Alignment.center,
                                child: seedsList[index].isSync == 0
                                    ? Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: const <Widget>[
                                          Icon(
                                            Icons.warning,
                                            color: Colors.deepOrange,
                                          ),
                                          Text('Sincronização pendente'),
                                        ],
                                      )
                                    : const Text("Dado sincronizado"),
                              )
                            ],
                          ),
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
