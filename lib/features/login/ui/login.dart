import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymsocial/features/login/widgets/text_input.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/config.dart';
import '../../../core/class/request_status.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/validator.dart';
import '../logic/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(LoginContImp());
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: GetBuilder<LoginContImp>(builder: (cont) {
            if(cont.requestStatus == RequestStatus.loading){
              return SizedBox(
                height: 85.h,
                width: 100.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    const CircularProgressIndicator(
                      color: black,
                    ),
                  ],
                ),
              );
            } else if(cont.requestStatus == RequestStatus.success || cont.requestStatus == RequestStatus.failure){
              return Form(
                key: cont.formstate,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5.h),
                    child: Column(
                      children: [
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              width: 40.w,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle
                              ),
                              child: Image.asset(
                                "assets/images/logo.png",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        TextInput(
                          controller: cont.email,
                          hintText: "Email Address",
                          isNumber: false,
                          isPassword: false,
                          suffixIcon: Icon(Icons.email, size: 20.sp, color: darkGrey,),
                          valid: (val) {
                            return validInput(val!, 5, 100, "email");
                          },
                        ),
                        SizedBox(height: 2.h),
                        TextInput(
                          controller: cont.pass,
                          hintText: "Password",
                          isNumber: false,
                          isPassword: cont.isShowPassword,
                          suffixIcon: GestureDetector(
                            onTap: (){
                              cont.showPassword();
                            },
                            child: cont.isShowPassword ?
                            Icon(Icons.visibility_outlined, size: 20.sp, color: darkGrey,) :
                            Icon(Icons.visibility_off_outlined, size: 20.sp, color: black,),
                          ),
                          valid: (val) {
                            return validInput(val!, 5, 100, "password");
                          },
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: (){},
                              child: Text(
                                "Forget Password?!",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                  color: Colors.blue
                                ),
                              ),
                            ),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 80.w,
                              child: ElevatedButton(
                                // focusNode: f3,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(black),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        vertical: 1.h
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'Cairo',
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  cont.login();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Don`t Have Account?!",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(screenSignUp);
                              },
                              child: Text(
                                "Sign Up",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue
                                ),
                              ),
                            ),
                            SizedBox(width: 5.w),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return SizedBox(
              height: 85.h,
              width: 100.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  const CircularProgressIndicator(
                    color: black,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
