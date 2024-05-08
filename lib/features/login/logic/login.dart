import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/config.dart';
import '../../../core/class/request_status.dart';
import '../../../core/constants/app_links.dart';
import '../../../core/constants/colors.dart';
import '../../../core/remote/requests.dart';
import '../../../core/repo/local/local.dart';

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
    try {
      var formdata = formstate.currentState;
      if (formdata!.validate()) {
        requestStatus = RequestStatus.loading;
        update();
        if (!isConnected) {
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

        Map data = {
          'email': email.text,
          'pass': pass.text,
        };
        var res = await requests.postData(data, AppLinks.login);
        if(RequestStatus.serverFailure == res){
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
        } else if(res['message'] == "not_verified"){
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
              "Email Not Verified !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
            onWillPop: () async {
              Get.back();
              Map data = {
                'email': email.text,
              };
              var verify = await requests.postData(data, AppLinks.sendVerifyCode);
              if(RequestStatus.serverFailure == verify){
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
              } else if(verify['message'] == "already_verified"){
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
                    "Already Verified !!",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Cairo",
                    ),
                  ),
                );
                requestStatus = RequestStatus.failure;
                update();
              } else if(verify['message'] == "success") {
                Map verify_email = {
                  'email': email.text,
                };
                await LocaleApi.saveTempVerify(verify_email);
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
                    "Success, Email Sent to you with verification code..",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Cairo",
                    ),
                  ),
                  onWillPop: () async {
                    Get.back();
                    Get.toNamed(screenEmailVerify);
                    return false;
                  },
                );
                requestStatus = RequestStatus.failure;
                update();
              }
              return false;
            },
          );
        } else if(res['message'] == "password_wrong"){
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
              "Password Incorrect !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          requestStatus = RequestStatus.failure;
          update();
        } else if(res['message'] == "not_exsist"){
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
              "Email Not Registered !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          requestStatus = RequestStatus.failure;
          update();
        } else if(res['message'] == "data_null"){
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
        } else if(res['message'] == "failed"){
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
        } else if(res['message'] == "success") {
          Map loginData = {
            'id': res['result']['id'],
            'email': email.text,
            'username': res['result']['username'],
            'bio': res['result']['bio'],
            'avatar': res['result']['avatar'] ?? "",
            'type': res['result']['type'],
            'status': res['result']['status'],
            'created_at': res['result']['created_at'],
          };
          var saveLogin = await LocaleApi.saveLoginData(loginData);
          if(saveLogin){
            Get.offAllNamed(screenHome);
            requestStatus = RequestStatus.failure;
            update();
          } else {
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
          }
        }
      }
    } catch(e){
      print("$e");
    }
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