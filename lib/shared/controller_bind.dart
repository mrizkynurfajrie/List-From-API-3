import 'package:get/get.dart';
import 'package:penggajian/features/penggajian/api_penggajian.dart';
import 'package:penggajian/features/penggajian/controller_penggajian.dart';

class ControllerBind extends Bindings {
  @override
  void dependencies() {
    Get.put(ControllerPenggajian(api: ApiPenggajian()));
  }
}
