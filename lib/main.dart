import 'package:e_commerce/app/modules/home/home_bindings.dart';
import 'package:e_commerce/app/routes/app_pages.dart';
import 'package:e_commerce/app/ui/theme/app_theme.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.initial,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
   initialBinding: HomeBindings(),
  ));
}
