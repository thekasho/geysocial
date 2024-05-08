import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/constants/colors.dart';

class CustomAppBarButton extends StatelessWidget {
  final void Function() onPressed;
  final IconData buttonIcon;
  final bool active;

  const CustomAppBarButton({
    super.key,
    required this.onPressed,
    required this.buttonIcon,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18.w,
      child: MaterialButton(
        onPressed: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              buttonIcon,
              color: active == true ? landingBackground : darkGrey,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
