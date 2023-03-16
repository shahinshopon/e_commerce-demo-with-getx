import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/app/modules/cart/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var isLoading = false;
   final products = RxList<CartModel>([]);
  @override
  void onInit() {
    getCartData();
    getCount();
    super.onInit();
  }

  Future getCartData() async {
    try {
      QuerySnapshot productlist = await FirebaseFirestore.instance
          .collection('cart-item')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('my-cart')
          .orderBy('date')
          .get();
      products.clear();
      for (var product in productlist.docs) {
        products.add(CartModel(
            product['product-name'],
            product['product-price'],
            product['product-description'],
            product['product-image'],
            product['product-quantity'],
            product['product-total']
            ));
      }
      isLoading = false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  var subtotal = 0.obs;
  var total = 0.obs;

  Future<RxInt> getCount() async {
    // Sum the count of each shard in the subcollection
    final shards = await FirebaseFirestore.instance
        .collection('cart-item')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('my-cart')
        .get();

    var totalCount = 0.obs;

    shards.docs.forEach(
      (doc) {
        totalCount.value += doc.data()['product-total'] as int;
        total.value = subtotal.value + totalCount.value;
        // if (mounted) setState(() {});
      },
    );

    return total;
  }
}
