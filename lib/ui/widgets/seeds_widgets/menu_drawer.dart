import 'package:flutter/material.dart';
import 'package:seeds_system/utils/custom_icons.dart';
import 'package:seeds_system/ui/widgets/seeds_widgets/modal_bottom_sheet_form.dart';
import '../../../routes.dart';
import '../../../utils/userId_preferences.dart';
import 'package:seeds_system/ui/widgets/seeds_widgets/show_modal_bottom.dart';

class MenuDrawerWidget extends StatelessWidget {
  const MenuDrawerWidget({Key? key}) : super(key: key);
  final padding = const EdgeInsets.all(20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.green.shade200,
        child: ListView(
          children: <Widget>[
            Container(
              padding: padding,
              child: Column(
                children: [
                  buildMenuItem(
                      text: 'Cadastro de sementes',
                      icon: CustomIcons.plantinha,
                      onClicked: () =>
                          showModalBottom(context, const PostSeeds())),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Sincronizar sementes',
                    icon: Icons.sync,
                    onClicked: () {},
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Logout',
                    icon: CustomIcons.aceno,
                    onClicked: () async {
                      await UserPreferences().prefsClear();
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

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      onTap: onClicked,
    );
  }
}
