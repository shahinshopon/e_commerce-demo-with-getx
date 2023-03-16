import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/app/modules/favourite/favourite_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  var isLoading = false;
  final products = RxList<FavouriteModel>([]);
  @override
  void onInit() {
     getFavouriteData();

    super.onInit();
    // ever(products, (value) {
    //   getFavouriteData();
    // });
  }

  getFavouriteData() async {
    try {
      QuerySnapshot productlist = await FirebaseFirestore.instance
          .collection('favourite-item')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('my-favourite')
          .orderBy('date')
          .get();
      products.clear();
      for (var product in productlist.docs) {
        products.add(FavouriteModel(
          product['product-name'],
          product['product-price'],
          product['product-description'],
          product['product-image'],
        ));
      }
      isLoading = false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
