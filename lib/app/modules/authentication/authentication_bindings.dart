import 'package:get/get.dart';
import './authentication_controller.dart';

class AuthenticationBindings implements Bindings {
    @override
    void dependencies() {
        Get.put<AuthenticationController>(AuthenticationController());
    }
}