import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/constants/colors.dart';
import '../logic/home.dart';
import '../widgets/custom_bottom_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeContImp());
    return GetBuilder<HomeContImp>(builder: (cont) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          leadingWidth: 100.w,
          toolbarHeight: 9.h,
          leading: Row(
            children: [
              SizedBox(width: 2.w),
              Image.asset("assets/images/logo.png", width: 15.w,),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomAppBar(),
        body: cont.pagesList.elementAt(cont.currentPage),
      );
    });
  }
}
