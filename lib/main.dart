import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymsocial/routes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'config/config.dart';
import 'core/binding/binding.dart';
import 'core/constants/constants.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
        builder: (context, orient, type) {

          return GetMaterialApp(
            title: kAppName,
            theme: MyThemApp.themeData(context),
            debugShowCheckedModeBanner: false,
            textDirection: TextDirection.ltr,
            initialBinding: InitialBinding(),
            initialRoute: screenLanding,
            getPages: routes,
          );
        }
    );
  }
}
