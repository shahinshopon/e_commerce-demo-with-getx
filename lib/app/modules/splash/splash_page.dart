import 'package:e_commerce/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var box = GetStorage();
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 3), () => checkUser());
    super.initState();
  }

  Future checkUser()  async{
    var uid = box.read('uid');
     if (uid == null) {
      Get.toNamed(Routes.signin);
     } else{
      Get.toNamed(Routes.bottomNavController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FlutterLogo(
                size: 100,
              ),
              Text(
                'E-commerce Demo',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
