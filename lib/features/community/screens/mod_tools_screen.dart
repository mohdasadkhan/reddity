import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreens extends StatelessWidget {
  final String name;
  const ModToolsScreens({
    Key? key,
    required this.name,
  }) : super(key: key);

  void navigateToEditCommunity(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$name');
  }

  void navigateToAddModsScreen(BuildContext context) {
    Routemaster.of(context).push('/add-mods/$name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod Tools'),
      ),
      body: Column(children: [
        ListTile(
          leading: const Icon(Icons.add_moderator),
          title: const Text('Add Moderators'),
          onTap: () => navigateToAddModsScreen(context),
        ),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Edit Community'),
          onTap: () => navigateToEditCommunity(context),
        ),
      ]),
    );
  }
}
