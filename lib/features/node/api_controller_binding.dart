import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiNode {}

class BindingNode implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ControllerNode(api: ApiNode()));
  }
}

class ControllerNode extends GetxController {
  final ApiNode api;
  ControllerNode({required this.api});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
