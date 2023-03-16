import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/app/ui/theme/app_text_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './cart_controller.dart';

class CartPage extends GetView<CartController> {
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    cartController.getCartData();
    cartController.getCount();
    return GetBuilder<CartController>(
        init: CartController(),
        initState: (_) {},
        builder: (cartController) {
          cartController.getCartData();
          cartController.getCount();
          return Obx(()=>Scaffold(
              // appBar: AppBar(
              //   title: const Text('CartPage'),
              // ),
              body: cartController.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: cartController.products.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Card(
                                      child: ListTile(
                                        leading: Image.network(
                                          cartController.products[index].image!,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        title: Text(cartController
                                            .products[index].name!),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(cartController
                                                .products[index].quantity
                                                .toString()),
                                            const Text('x'),
                                            Text(cartController
                                                .products[index].price!),
                                          ],
                                        ),
                                        trailing: SizedBox(
                                          width: 80,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(cartController
                                                  .products[index].total
                                                  .toString()),
                                              IconButton(
                                                  onPressed: () {
                                                    //remove from firebase
                                                    FirebaseFirestore.instance
                                                        .collection('cart-item')
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .email)
                                                        .collection('my-cart')
                                                        .where('product-name',
                                                            isEqualTo:
                                                                cartController
                                                                    .products[
                                                                        index]
                                                                    .name)
                                                        .get()
                                                        .then((snapshot) {
                                                      for (var doc
                                                          in snapshot.docs) {
                                                        doc.reference.delete();
                                                      }
                                                    }).whenComplete(() =>
                                                            cartController.onInit());
                                                    //remove from model
                                                    // cartController.products
                                                    //     .removeAt(index);
                                                    // cartController.products;

                                                    // cartController.products.remove(
                                                    //     CartModel(
                                                    //         cartController
                                                    //             .products[index]
                                                    //             .name,
                                                    //         cartController
                                                    //             .products[index]
                                                    //             .price,
                                                    //         cartController
                                                    //             .products[index]
                                                    //             .description,
                                                    //         cartController
                                                    //             .products[index]
                                                    //             .image,
                                                    //         cartController
                                                    //             .products[index]
                                                    //             .quantity,
                                                    //         cartController
                                                    //             .products[index]
                                                    //             .total));
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: cardTextStyle,
                              ),
                              Obx(() => Text(cartController.total.toString())),
                            ],
                          )
                        ],
                      ),
                    )));
        });
  }
}
