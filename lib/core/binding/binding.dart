import 'package:get/get.dart';

import '../class/crud.dart';
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
  }
}