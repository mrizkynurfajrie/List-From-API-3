import 'package:get/get.dart';
import 'package:penggajian/features/home/page_home.dart';
import 'package:penggajian/features/node/api_controller_binding.dart';
import 'package:penggajian/features/node/page_node.dart';
import 'package:penggajian/features/node/path/Home.dart';
import 'package:penggajian/features/penggajian/binding_penggajian.dart';
import 'package:penggajian/features/penggajian/page_penggajian.dart';
import 'package:penggajian/routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const PageHome(),
    ),
    GetPage(
      name: Routes.penggajianPage,
      page: () => const PagePenggajian(),
      binding: BindingPenggajian(),
    ),
    GetPage(
      name: Routes.nodePage,
      page: () => PagePath(),
    ),
  ];
}
