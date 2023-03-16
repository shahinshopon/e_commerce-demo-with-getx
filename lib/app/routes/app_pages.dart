import 'package:e_commerce/app/modules/authentication/authentication_page.dart';
import 'package:e_commerce/app/modules/bottom_nav_controller.dart';
import 'package:e_commerce/app/modules/home/details.dart';
import 'package:e_commerce/app/modules/splash/splash_page.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(name: Routes.initial, page: () => const SplashScreen()),
    GetPage(name: Routes.signin, page: () => AuthenticationPage()),
    GetPage(
        name: Routes.bottomNavController,
        page: () => const BottomNavController()),
    GetPage(
        name: Routes.details,
        page: () {
          DetailsScreen detailsScreen = Get.arguments;
          return detailsScreen;
        }),
  ];
}
