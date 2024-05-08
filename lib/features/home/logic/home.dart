import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gymsocial/config/config.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/class/request_status.dart';
import '../../../core/remote/requests.dart';
import '../../../core/repo/local/local.dart';

abstract class HomeCont extends GetxController {
  checkNetwork();
  checkAuth();
  changePage(int i);
  logOut();
}
class HomeContImp extends HomeCont {
  Requests requests = Requests(Get.find());
  RequestStatus requestStatus = RequestStatus.none;
  bool isConnected = false;
  String username = '';
  int currentPage = 0;

  List<Widget> pagesList = [
    const Column(mainAxisAlignment: MainAxisAlignment.center, children: [SafeArea(child: Center(child: Text("Home"),))],),
    const Column(mainAxisAlignment: MainAxisAlignment.center, children: [SafeArea(child: Center(child: Text("Cats"),))],),
    const Column(mainAxisAlignment: MainAxisAlignment.center, children: [SafeArea(child: Center(child: Text("Fav"),))],),
    const Column(mainAxisAlignment: MainAxisAlignment.center, children: [SafeArea(child: Center(child: Text("Notifications"),))],),
    const Column(mainAxisAlignment: MainAxisAlignment.center, children: [SafeArea(child: Center(child: Text("Settings"),))],),
  ];

  List pagesTitles = [
    "Home",
    "Categories",
    "Favourite",
    "Notifications",
    "Settings",
  ];

  List<IconData> pageIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.magnifyingGlass,
    FontAwesomeIcons.plus,
    FontAwesomeIcons.bell,
    FontAwesomeIcons.message,
  ];

  @override
  checkNetwork() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }

  @override
  changePage(int i) {
    currentPage = i;
    update();
  }

  @override
  checkAuth() async {
    var loginData  = await LocaleApi.getLoginData();
    if(loginData != null){
      username = loginData['username'];
      update();
    } else {
      Get.offAllNamed(screenLogin);
    }
  }

  @override
  logOut() async {
    try {
      var loginData  = await LocaleApi.getLoginData();
      if(loginData != null){
        await LocaleApi.removeLoginData();
        Get.offAllNamed(screenLogin);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void onInit() {
    requestStatus = RequestStatus.none;
    checkNetwork();
    checkAuth();
    super.onInit();
  }

}