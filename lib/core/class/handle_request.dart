import 'package:flutter/material.dart';
import 'package:gymsocial/core/class/request_status.dart';

import '../constants/colors.dart';

class HandleRequest extends StatelessWidget {
  const HandleRequest(
      {super.key, required this.statusRequest, required this.widget});

  final RequestStatus statusRequest;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return statusRequest == RequestStatus.loading
        ? const Center(
        child: CircularProgressIndicator(color: green))
        : statusRequest == RequestStatus.offlineFailure
        ? const Center(child: Text("You Are Offline"))
        : statusRequest == RequestStatus.serverFailure
        ? const Center(child: Text("Server Error"))
        : widget;
  }
}