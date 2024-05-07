import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../config/config.dart';
import '../../../core/class/request_status.dart';
import '../../../core/remote/requests.dart';
import '../../../core/repo/local/local.dart';

abstract class LandingCont extends GetxController {
  checkNetwork();
  checkAuth();
}
class LandingContImp extends LandingCont {
  Requests requests = Requests(Get.find());
  RequestStatus requestStatus = RequestStatus.loading;
  bool isConnected = false;

  @override
  checkNetwork() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }

  @override
  checkAuth() async {
    var loginData  = await LocaleApi.getLoginData();
    if(loginData != null){
      // Get.offAllNamed(screenHome);
    } else {
      Get.offAllNamed(screenLogin);
    }
  }

  @override
  void onInit() {
    requestStatus = RequestStatus.loading;
    checkNetwork();
    checkAuth();
    super.onInit();
  }

}