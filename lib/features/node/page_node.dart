import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penggajian/features/node/api_controller_binding.dart';
import 'package:penggajian/shared/widgets/page_decoration_top.dart';

class PageNode extends GetView<ControllerNode> {
  const PageNode({super.key});

  @override
  Widget build(BuildContext context) {
    return PageDecorationTop(
      title: '',
      enableBack: true,
      backgroundColor: Colors.amber.shade200,
      center: Center(
        child: Text(
          'Mencari Node Terdekat',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade100,
          ),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}
