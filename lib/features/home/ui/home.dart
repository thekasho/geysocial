import 'package:flutter/cupertino.dart';
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
          toolbarHeight: 9.5.h,
          actions: [
            DrawerButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[350]!,),
                shape: MaterialStateProperty.all<
                    RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(
                      vertical: 1.5.h,
                    horizontal: 3.w,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 2.h,
              ),
              width: 85.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Be Healthy",
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomAppBar(),
        body: cont.pagesList.elementAt(cont.currentPage),
        drawer: Drawer(
          backgroundColor: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                padding: EdgeInsets.only(top: 1.h),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                ),
                child: Container(
                  width: 10.w,
                  child: Column(
                    children: [
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/images/logo.png", width: 15.w,),
                          SizedBox(width: 5.w,),
                          Column(
                            children: [
                              Text(
                                "User Name",
                                style: TextStyle(
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "@12542",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Spacer(flex: 1,),
                          Text(
                            "10k",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(flex: 1,),
                          Text(
                            "Following",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                          const Spacer(flex: 3,),
                          Text(
                            "10k",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(flex: 1,),
                          Text(
                            "Following",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                          const Spacer(flex: 3,),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "User Name",
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
                onTap: () {

                },
              ),
              ListTile(
                title: Text(
                  "User Name",
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
                onTap: () {

                },
              ),
              ListTile(
                title: Text(
                  "User Name",
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
                onTap: () {

                },
              ),
              ListTile(
                title: Text(
                  "User Name",
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
                onTap: () {

                },
              ),
              ListTile(
                title: Text(
                  "User Name",
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
                onTap: () {

                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
