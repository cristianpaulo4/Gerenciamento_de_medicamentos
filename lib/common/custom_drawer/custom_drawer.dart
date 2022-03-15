import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/common/custom_drawer/custom_drawer_header.dart';
import 'package:gerenciamento_medicamentos/common/custom_drawer/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          CustomDrawerHeader(),
          DrawerTile(iconData: Icons.home, title: 'Inicio', page: 0,),
          DrawerTile(iconData: Icons.medication, title: 'Cadatro',page: 1,),
          DrawerTile(iconData: Icons.history, title: 'Historio',page: 2,),
        ],
      ),
    );
  }
}
