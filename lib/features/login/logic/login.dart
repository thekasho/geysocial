import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/class/request_status.dart';
import '../../../core/remote/requests.dart';

abstract class LoginCont extends GetxController {
  checkNetwork();
  login();
}
class LoginContImp extends LoginCont {
  Requests requests = Requests(Get.find());
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController pass;

  RequestStatus requestStatus = RequestStatus.none;

  bool isShowPassword = true;
  bool isConnected = false;

  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  @override
  checkNetwork() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }

  @override
  login() async {

  }

  @override
  void onInit() {
    requestStatus = RequestStatus.success;
    email = TextEditingController();
    pass = TextEditingController();
    checkNetwork();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

}