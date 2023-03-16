
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './authentication_controller.dart';

class AuthenticationPage extends StatelessWidget {
  AuthenticationController authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
        init: AuthenticationController(),
        initState: (_) {},
        builder: (authenticationController) {
         // authenticationController.signInWithGoogle(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('AuthenticationPage'),
            ),
            body: Center(
                child: SizedBox(
                  height: 50,
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () => authenticationController. signInWithGoogle(context),
                child: const Center(child: Text('Sign In With Google')),
              ),
            )),
          );
        });
  }
}
