import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/validator.dart';
import '../../login/widgets/text_input.dart';
import '../logic/email_verify.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({super.key});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(EmailVerifyContImp());
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: GetBuilder<EmailVerifyContImp>(builder: (cont) {
            return Form(
              key: cont.formstate,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: Column(
                    children: [
                      SizedBox(height: 1.h),
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
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 100.w,
                            height: 6.h,
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Text(
                              "Enter Your Verify Code",
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: landingBackground
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      TextInput(
                        controller: cont.code,
                        hintText: "Verify Code",
                        isNumber: false,
                        isPassword: false,
                        suffixIcon: Icon(Icons.key_sharp, size: 20.sp, color: darkGrey,),
                        valid: (val) {
                          return validInput(val!, 5, 100, "username");
                        },
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80.w,
                            child: ElevatedButton(
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
                                "Verify Account",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontFamily: 'Cairo',
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                cont.verify();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
