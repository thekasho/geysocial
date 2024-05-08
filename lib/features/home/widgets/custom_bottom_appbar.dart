import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../logic/home.dart';
import 'custom_appbar_button.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeContImp>(builder: (cont) {
      return BottomAppBar(
        child: Row(
          children: [
            ...List.generate(
              cont.pagesList.length + 1, (index) {
              int i = index > 2 ? index - 1 : index;
              return index == 2 ? const Spacer() :
              CustomAppBarButton(
                  buttonIcon: cont.pageIcons[i],
                  active: cont.currentPage == i ? true : false,
                  onPressed: () => cont.changePage(i)
              );
            },
            ),
          ],
        ),
      );
    });
  }
}