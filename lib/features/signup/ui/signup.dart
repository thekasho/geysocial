import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gymsocial/config/config.dart';
import 'package:gymsocial/features/signup/logic/signup.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../../core/class/request_status.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/validator.dart';
import '../../login/widgets/text_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  final List<Map<String, dynamic>> _live = [
    {
      'value': '2',
      'label': 'Coach',
    },
    {
      'value': '1',
      'label': 'User / Trainee',
    },
  ];


  @override
  Widget build(BuildContext context) {
    Get.put(SignUpContImp());
    String user_type = '1';
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: GetBuilder<SignUpContImp>(builder: (cont) {
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
                        SizedBox(
                          width: 90.w,
                          child: SelectFormField(
                            validator: (val){
                              if (val!.isEmpty) {
                                return "required";
                              }
                            },
                            type: SelectFormFieldType.dropdown,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 15.sp,
                                  color: black
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1, color: black,),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15.sp,
                                  fontFamily: 'Cairo'
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 2.5.h
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: red),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            initialValue: '1',
                            labelText: 'Select Account Type',
                            items: _live,
                            onChanged: (val) {
                              user_type = val;
                            },
                            onSaved: (val) {
                              user_type = val!;
                            },
                            onFieldSubmitted: (val) {
                              user_type = val!;
                            },
                          ),
                        ),
                        SizedBox(height: 2.h),
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
                          controller: cont.username,
                          hintText: "Your Username",
                          isNumber: false,
                          isPassword: false,
                          suffixIcon: Icon(FontAwesomeIcons.solidUser, size: 20.sp, color: darkGrey,),
                          valid: (val) {
                            return validInput(val!, 5, 100, "username");
                          },
                        ),
                        SizedBox(height: 2.h),
                        TextInput(
                          controller: cont.bio,
                          hintText: "Your BIO",
                          isNumber: false,
                          isPassword: false,
                          suffixIcon: Icon(FontAwesomeIcons.circleInfo, size: 20.sp, color: darkGrey,),
                          valid: (val) {
                            print(val);
                            return;
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
                        TextInput(
                          controller: cont.repass,
                          hintText: "Confirm Password",
                          isNumber: false,
                          isPassword: cont.isShowrePassword,
                          suffixIcon: GestureDetector(
                            onTap: (){
                              cont.showrePassword();
                            },
                            child: cont.isShowrePassword ?
                            Icon(Icons.visibility_outlined, size: 20.sp, color: darkGrey,) :
                            Icon(Icons.visibility_off_outlined, size: 20.sp, color: lightRed,),
                          ),
                          valid: (val) {
                            return validInput(val!, 5, 100, "password");
                          },
                        ),
                        SizedBox(height: 5.h),
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
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'Cairo',
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  cont.register(user_type);
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
                              "Already Have Account?!",
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
                                Get.back();
                                Get.toNamed(screenLogin);
                              },
                              child: Text(
                                "Login",
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
