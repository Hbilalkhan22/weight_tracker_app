import 'package:get/get.dart';
import 'package:weight_tracker/main.dart';

import '../modules/Auth/views/auth_view.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static var INITIAL =
      box.read('userEmail') != null ? Routes.HOME : Routes.AUTH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
    ),
  ];
}
