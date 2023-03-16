import 'package:e_commerce/app/modules/home/details.dart';
import 'package:e_commerce/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './home_controller.dart';

class HomePage extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        initState: (_) {},
        builder: (homeController) {
          homeController.getData();
          return Scaffold(
              body: homeController.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.details,
                                arguments: DetailsScreen(
                                    homeController.products[index].name,
                                    homeController.products[index].price,
                                    homeController.products[index].description,
                                    homeController.products[index].images,)
                                    );
                          },
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.network(
                                  homeController.products[index].images[0],
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(homeController.products[index].name),
                                    Text(homeController.products[index].price),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: homeController.products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.8),
                    ));
        });
  }
}
