import 'package:flutter/material.dart';
import '../../../routes.dart';
import '../../../utils/userId_preferences.dart';

class MenuDrawerWidget extends StatelessWidget {
  const MenuDrawerWidget({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  void _clearExternalId() async {
    await UserIdPreferences().prefsClear();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.green.shade200,
        child: ListView(
          children: <Widget>[
            buildHeader(
              name: "",
              email: "",
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Cadastro de Sementes',
                    icon: Icons.add_box_outlined,
                    onClicked: () async {
                      Navigator.of(context).pushNamed(postSeedsRoute);
                      _clearExternalId;
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Sincronizar sementes',
                    icon: Icons.sync,
                    onClicked: () {},
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout_rounded,
                    onClicked: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          authScreenRoute, (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String name,
    required String email,
  }) =>
      InkWell(
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.black;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
