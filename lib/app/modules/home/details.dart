import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/app/modules/cart/cart_controller.dart';
import 'package:e_commerce/app/modules/cart/cart_model.dart';
import 'package:e_commerce/app/modules/favourite/favourite_controller.dart';
import 'package:e_commerce/app/modules/favourite/favourite_model.dart';
import 'package:e_commerce/app/modules/home/home_controller.dart';
import 'package:e_commerce/app/ui/theme/app_colors.dart';
import 'package:e_commerce/app/ui/theme/app_text_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatelessWidget {
  String name;
  String price;
  String description;
  List images;
  DetailsScreen(this.name, this.price, this.description, this.images);
  RxInt number = 1.obs;
  HomeController homeController = Get.put(HomeController());
  CartController cartController = Get.put(CartController());
  FavouriteController favouriteController = Get.put(FavouriteController());
  // RxBool isCheck = false.obs;
  @override
  Widget build(BuildContext context) {
    homeController.checkerFavouriteIcon(name);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
              onPressed: () {
                try {
                  //check if already in favourite item collection
                  FirebaseFirestore.instance
                      .collection('favourite-item')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection('my-favourite')
                      .where('product-name', isEqualTo: name)
                      .get()
                      .then((value) {
                    if (value.docs.isNotEmpty) {
                      //if value==true show a snacbar
                      Get.snackbar(name, 'Already Added');
                    } else {
                      //if value==false add data in firestore
                      FirebaseFirestore.instance
                          .collection('favourite-item')
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .collection('my-favourite')
                          .doc()
                          .set({
                        'product-name': name,
                        'product-price': price,
                        'product-description': description,
                        'product-image': images[0],
                        'date': DateTime.now().toString()
                      });
                      Get.snackbar(name, 'Successfully Added');
                      homeController.isCheck.value = true;
                      // add data model
                      favouriteController.products.add(FavouriteModel(
                        name,
                        price,
                        description,
                        images[0],
                      ));
                    }
                  });
                } catch (e) {
                  Get.snackbar("Failed", e.toString());
                }
              },
              icon: Obx(() => homeController.isCheck.value
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.network(
                        images[index],
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        // width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
            ),
            minimumSpace,
            Text(
              name,
              style: cardTextStyle,
            ),
            minimumSpace,
            Text(price, style: cardTextStyle),
            minimumSpace,
            Text(description),
            maximumSpace,
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: purpleColor,
                  child: Align(
                    alignment: Alignment.center,
                    child: IconButton(
                        iconSize: 30,
                        splashColor: splashColor,
                        color: lightColor,
                        onPressed: () {
                          number.value += 1;
                        },
                        icon: const Icon(Icons.add)),
                  ),
                ),
                //  Obx(() =>
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    number.value.toString(),
                    style: cardTextStyle,
                  ),
                  // )
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: purpleColor,
                  child: Align(
                    alignment: Alignment.center,
                    child: IconButton(
                        iconSize: 30,
                        splashColor: splashColor,
                        color: lightColor,
                        onPressed: () {
                          if (number.value > 1) {
                            number.value -= 1;
                          } else {
                            Get.snackbar('Warning', 'Minimum Quantity 1');
                          }
                        },
                        icon: const Icon(Icons.remove)),
                  ),
                ),
              ],
            ),
            maximumSpace,
            SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                    onPressed: () {
                      try {
                        FirebaseFirestore.instance
                            .collection('cart-item')
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection('my-cart')
                            .where('product-name', isEqualTo: name)
                            .get()
                            .then((value) {
                          if (value.docs.isNotEmpty) {
                            Get.snackbar(name, 'Already Added');
                          } else {
                            FirebaseFirestore.instance
                                .collection('cart-item')
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection('my-cart')
                                .doc()
                                .set({
                              'product-name': name,
                              'product-price': price,
                              'product-description': description,
                              'product-image': images[0],
                              'product-quantity': number.value.toInt(),
                              'product-total':
                                  int.parse(price) * number.value.toInt(),
                              'date': DateTime.now().toString()
                            });
                            Get.snackbar(name, 'Successfully Added');
                            // add data model
                            cartController.products.add(CartModel(
                                name,
                                price,
                                description,
                                images[0],
                                number.value.toInt(),
                                int.parse(price) * number.value.toInt()));
                          }
                        });
                      } catch (e) {
                        Get.snackbar("Failed", e.toString());
                      }
                    },
                    child: Text(
                      'Add to Cart',
                      style: cardTextStyle,
                    )))
          ],
        ),
      ),
    );
  }
}
