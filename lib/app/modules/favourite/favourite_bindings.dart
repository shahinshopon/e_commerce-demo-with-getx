import 'package:get/get.dart';
import './favourite_controller.dart';

class FavouriteBindings implements Bindings {
    @override
    void dependencies() {
        Get.put<FavouriteController>(FavouriteController());
    }
}