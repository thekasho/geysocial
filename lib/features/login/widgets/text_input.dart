import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/constants/colors.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) valid;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final String hintText;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final bool isPassword;
  final Color? fillColor;
  final Function(String)? onChanged;
  final bool isNumber;

  const TextInput({super.key,
    required this.controller,
    required this.valid,
    this.focusNode,
    this.onFieldSubmitted,
    required this.hintText,
    this.suffixIcon, this.suffixIconColor, required this.isPassword, this.fillColor, this.onChanged, required this.isNumber});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      child: TextFormField(
        controller: controller,
        validator: valid,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        autofocus: false,
        obscureText: isPassword,
        keyboardType: isNumber == true ? TextInputType.number : TextInputType.text,
        style: TextStyle(
          fontSize: 15.sp,
          color: black,
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 15.sp,
              color: darkGrey
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.5, color: black,),
            borderRadius: BorderRadius.circular(15),
          ),
          errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 15.sp,
              fontFamily: 'Cairo'
          ),
          filled: true,
          fillColor: fillColor ?? white,
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
      ),
    );
  }
}


class AuthInputField extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconData;
  final TextEditingController mycontroller;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool isPassword;
  final void Function()? onTapIcon;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  const AuthInputField({super.key, required this.hinttext, required this.labeltext, required this.iconData, required this.mycontroller, required this.valid, required this.isNumber, required this.isPassword, this.onTapIcon, this.focusNode, this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Form(
          key: GlobalKey(),
          child: TextFormField(
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            validator: valid,
            controller: mycontroller,
            obscureText: isPassword,
            keyboardType: isNumber == true
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
            style: Theme.of(context).textTheme.titleSmall,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: 2.5.h
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              label: Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 0),
                child: Text(labeltext, style: Theme.of(context).textTheme.titleSmall),
              ),
              suffixIcon: InkWell(
                onTap: onTapIcon,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Icon(iconData, size: 30),
                ),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
        )
    );
  }
}
