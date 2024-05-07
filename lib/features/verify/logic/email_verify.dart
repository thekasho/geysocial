import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymsocial/config/config.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../core/class/request_status.dart';
import '../../../core/constants/app_links.dart';
import '../../../core/constants/colors.dart';
import '../../../core/remote/requests.dart';
import '../../../core/repo/local/local.dart';

abstract class EmailVerifyCont extends GetxController {
  checkNetwork();
  verify();
}
class EmailVerifyContImp extends EmailVerifyCont {
  Requests requests = Requests(Get.find());
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController code;
  RequestStatus requestStatus = RequestStatus.none;
  bool isConnected = false;
  String email = "";

  @override
  checkNetwork() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }

  @override
  verify() async {
    try {
      var formdata = formstate.currentState;
      if (formdata!.validate()) {
        requestStatus = RequestStatus.loading;
        update();
        if(!isConnected){
          Get.defaultDialog(
            backgroundColor: white,
            title: "Error",
            titlePadding: EdgeInsets.only(bottom: 2.h, top: 1.h),
            titleStyle: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
                color: red,
                fontWeight: FontWeight.bold
            ),
            content: Text(
              "No Internet Connection !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          requestStatus = RequestStatus.failure;
          update();
          return;
        }

        var loginData  = await LocaleApi.getTempVerify();
        if(loginData != null){
          email = loginData['email'];
          update();
        }
        Map data = {
          'email': email,
          'code': code.text,
        };
        var verifyData = await requests.postData(data, AppLinks.verifyEmail);
        if(RequestStatus.serverFailure == verifyData){
          Get.defaultDialog(
            backgroundColor: white,
            title: "Error",
            titlePadding: EdgeInsets.only(bottom: 2.h, top: 1.h),
            titleStyle: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
                color: red,
                fontWeight: FontWeight.bold
            ),
            content: Text(
              "Server Error !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          requestStatus = RequestStatus.failure;
          update();
        } else if(verifyData['message'] == "invalid_code"){
          Get.defaultDialog(
            backgroundColor: white,
            title: "Error",
            titlePadding: EdgeInsets.only(bottom: 2.h, top: 1.h),
            titleStyle: TextStyle(
              fontSize: 18.sp,
              fontFamily: "Cairo",
              color: red,
              fontWeight: FontWeight.bold,
            ),
            content: Text(
              "Code is Invalid !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          requestStatus = RequestStatus.failure;
          update();
        } else if(verifyData['message'] == "data_null"){
          Get.defaultDialog(
            backgroundColor: white,
            title: "Error",
            titlePadding: EdgeInsets.only(bottom: 2.h, top: 1.h),
            titleStyle: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
                color: red,
                fontWeight: FontWeight.bold
            ),
            content: Text(
              "Server Error !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          requestStatus = RequestStatus.failure;
          update();
        } else if(verifyData['message'] == "failed"){
          Get.defaultDialog(
            backgroundColor: white,
            title: "Error",
            titlePadding: EdgeInsets.only(bottom: 2.h, top: 1.h),
            titleStyle: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
                color: red,
                fontWeight: FontWeight.bold
            ),
            content: Text(
              "Server Error !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          requestStatus = RequestStatus.failure;
          update();
        } else if(verifyData['message'] == "success") {
          await LocaleApi.removeTempVerify();
          Get.defaultDialog(
            backgroundColor: white,
            title: "Success",
            titlePadding: EdgeInsets.only(bottom: 2.h, top: 1.h),
            titleStyle: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
                color: green,
                fontWeight: FontWeight.bold
            ),
            content: Text(
              "Success, Account Verified..",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
            onWillPop: () async {
              Get.back();
              // Get.back();
              Get.toNamed(screenLogin);
              return false;
            },
          );
          requestStatus = RequestStatus.success;
          update();
        }
      }
    } catch(e){
      print("$e");
    }
  }


  @override
  void onInit() {
    code = TextEditingController();
    checkNetwork();
    requestStatus = RequestStatus.success;
    super.onInit();
  }

  @override
  void dispose() {
    code.dispose();
    super.dispose();
  }

}