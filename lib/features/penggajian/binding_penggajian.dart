import 'package:get/get.dart';
import 'package:penggajian/features/penggajian/api_penggajian.dart';
import 'package:penggajian/features/penggajian/controller_penggajian.dart';

class BindingPenggajian implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ControllerPenggajian(api: ApiPenggajian()));
  }
}
