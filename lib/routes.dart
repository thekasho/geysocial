import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:gymsocial/features/home/ui/home.dart';

import 'config/config.dart';
import 'features/landing/ui/home.dart';
import 'features/login/ui/login.dart';
import 'features/signup/ui/signup.dart';
import 'features/verify/ui/email_verify.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: screenLanding, page: () => const LandingScreen()),

  GetPage(name: screenLogin, page: () => const LoginScreen()),
  GetPage(name: screenSignUp, page: () => const SignUpScreen()),
  GetPage(name: screenEmailVerify, page: () => const EmailVerifyScreen()),
  GetPage(name: screenHome, page: () => const HomeScreen()),

];

