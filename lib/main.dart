import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:penggajian/routes/app_pages.dart';
import 'package:penggajian/routes/app_routes.dart';
import 'package:penggajian/shared/controller_bind.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  String pageName = '';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  updatePageRoute(value) {
    try {
      var name = value!.route!.settings.name.toString();
      log(name);
      setState(() {
        pageName = name;
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      designSize: const Size(393, 830),
      builder: () => GetMaterialApp(
        navigatorKey: Get.key,
        title: 'AntarAnter-Driver',
        theme: ThemeData(
          platform: TargetPlatform.android,
          brightness: Brightness.light,
          primaryColor: Colors.blue.shade700,
          fontFamily: 'DMSans',
        ),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            ///Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                dismisKeyboard();
              },
              child: Stack(children: [
                child!,
              ]),
            ),
          );
        },
        getPages: AppPages.pages,
        initialRoute: Routes.initial,
        // translationsKeys: AppTranslation.translations,
        locale: const Locale('id', 'ID'),
        routingCallback: (value) {
          if (value != null) {
            updatePageRoute(value);
          }
        },
        defaultTransition: Transition.cupertino,
      ),
    );
  }
}

dismisKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
