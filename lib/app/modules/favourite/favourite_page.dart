import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/app/ui/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './favourite_controller.dart';

class FavouritePage extends StatelessWidget {
  FavouriteController favouriteController = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    favouriteController.getFavouriteData();
    return GetBuilder<FavouriteController>(
        init: FavouriteController(),
        initState: (_) {},
        builder: (favouriteController) {
          favouriteController.getFavouriteData();
          return Obx(()=>Scaffold(
              // appBar: AppBar(
              //   title: const Text('CartPage'),
              // ),
              body: favouriteController.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: favouriteController.products.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Card(
                                      child: ListTile(
                                        leading: Image.network(
                                          favouriteController
                                              .products[index].image!,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        title: Text(favouriteController
                                            .products[index].name!),
                                        subtitle: Text(favouriteController
                                            .products[index].price!),
                                        trailing: IconButton(
                                            onPressed: () async {
                                              //remove from firebase
                                              FirebaseFirestore.instance
                                                  .collection('favourite-item')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.email)
                                                  .collection('my-favourite')
                                                  .where('product-name',
                                                      isEqualTo:
                                                          favouriteController
                                                              .products[index]
                                                              .name)
                                                  .get()
                                                  .then((snapshot) {
                                                for (var doc in snapshot.docs) {
                                                  doc.reference.delete();
                                                }
                                              })
                                              .whenComplete(() {
                                              // favouriteController.products
                                              //     .remove(favouriteController
                                              //         .products[index]);

                                               favouriteController.onInit();
                                              // favouriteController.obs;
                                              });

                                              //remove from model
                                              // favouriteController.products
                                              //     .removeAt(index);
                                              //  favouriteController.products;
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: redColor,
                                            )),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    )));
        });
  }
}
