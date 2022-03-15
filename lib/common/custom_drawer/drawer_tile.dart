import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/colors.dart';
import 'package:gerenciamento_medicamentos/models/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {

  const DrawerTile({this.iconData, this.title, this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {

    final int curParge = context.watch<PageManager>().page;
    final Color primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page);
      },

      child: SizedBox(
        height: 60,
        child: Row(
          children: [

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: curParge == page ? primaryColor : ColorsApp.grey,
              ),
            ),

            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: curParge == page ? primaryColor : ColorsApp.grey,
              ),
            )

          ],
        ),
      ),
    );
  }
}
