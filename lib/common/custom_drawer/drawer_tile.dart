import 'package:flutter/material.dart';
import 'package:gerenciamento_medicamentos/models/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {

  const DrawerTile({required this.iconData, required this.title, required this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {

    final int curParge = context.watch<PageManager>().page;

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
                color: curParge == page ? Colors.red : Colors.grey[700],
              ),
            ),

            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: curParge == page ? Colors.red : Colors.grey[700],
              ),
            )

          ],
        ),
      ),
    );
  }
}
