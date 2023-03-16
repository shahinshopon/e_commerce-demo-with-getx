import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/app/modules/home/home_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = false;
  final List products = <HomeModel>[];
  RxBool isCheck = false.obs;
  var name;
  @override
  void onInit() {
    getData();
    checkerFavouriteIcon(name);
    super.onInit();
  }

  Future getData() async {
    try {
      QuerySnapshot productlist = await FirebaseFirestore.instance
          .collection('all-products')
          // .orderBy('product-name')
          .get();
      products.clear();
      for (var product in productlist.docs) {
        products.add(HomeModel(
          product['product-name'],
          product['product-price'],
          product['product-description'],
          product['product-img'],
        ));
      }
      isLoading = false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  //checker for favourite icon
  Future checkerFavouriteIcon(name) async {
    try {
      FirebaseFirestore.instance
          .collection('favourite-item')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('my-favourite')
          .where('product-name', isEqualTo: name)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          isCheck.value = true;
        } else {
          isCheck.value = false;
        }
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
