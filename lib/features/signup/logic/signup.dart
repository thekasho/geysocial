import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/config.dart';
import '../../../core/class/request_status.dart';
import '../../../core/constants/app_links.dart';
import '../../../core/constants/colors.dart';
import '../../../core/remote/requests.dart';
import '../../../core/repo/local/local.dart';

abstract class SignUpCont extends GetxController {
  checkNetwork();
  register(String type);
}
class SignUpContImp extends SignUpCont {
  Requests requests = Requests(Get.find());
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  // late TextEditingController type;
  late TextEditingController email;
  late TextEditingController username;
  late TextEditingController bio;
  late TextEditingController pass;
  late TextEditingController repass;

  RequestStatus requestStatus = RequestStatus.none;

  bool isShowPassword = true;
  bool isShowrePassword = true;
  bool isConnected = false;

  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  showrePassword() {
    isShowrePassword = isShowrePassword == true ? false : true;
    update();
  }

  @override
  checkNetwork() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }

  @override
  register(type) async {
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

        Map data = {
          'type': type,
          'email': email.text,
          'username': username.text,
          'bio': bio.text,
          'pass': pass.text,
        };

        var auth = await requests.postData(data, AppLinks.register);
        if(RequestStatus.serverFailure == auth){
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
        } else if(auth['message'] == "email_exsist"){
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
              "Email Already in use !!",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
          requestStatus = RequestStatus.failure;
          update();
        } else if(auth['message'] == "data_null"){
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
        } else if(auth['message'] == "failed"){
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
        } else if(auth['message'] == "success") {
          try {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email.text,
              password: pass.text,
            );
          } on FirebaseAuthException catch (x) {
            print("Error: $x");
          } on Exception catch (e) {
            print("Error: $e");
          }
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
              // Get.back();
              Get.toNamed(screenEmailVerify);
              return false;
            },
          );
          requestStatus = RequestStatus.success;
          update();
        }

        requestStatus = RequestStatus.success;
        update();
      }
    } catch (e){
      print("Error: $e");
    }
  }

  @override
  void onInit() {
    // type = TextEditingController();
    email = TextEditingController();
    username = TextEditingController();
    bio = TextEditingController();
    pass = TextEditingController();
    repass = TextEditingController();
    checkNetwork();
    requestStatus = RequestStatus.success;
    super.onInit();
  }

  @override
  void dispose() {
    // type.dispose();
    email.dispose();
    username.dispose();
    bio.dispose();
    pass.dispose();
    repass.dispose();
    super.dispose();
  }

}