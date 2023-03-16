import 'package:e_commerce/app/modules/cart/cart_page.dart';
import 'package:e_commerce/app/modules/favourite/favourite_page.dart';
import 'package:e_commerce/app/modules/home/home_page.dart';
import 'package:e_commerce/app/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({super.key});

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  int _currentIndex = 0;
  final _pages =  [HomePage(), FavouritePage(), CartPage()];
  signOut() async {
    var result = await FirebaseAuth.instance.signOut();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Center(
          child: ElevatedButton(
              onPressed: () async {
                await signOut();
                Get.toNamed(Routes.signin);
              },
              child: const Text('Log Out')),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFF5364F4),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline, color: Colors.black),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
            label: 'Cart',
          ),
        ],
      ),
      body: _pages[_currentIndex],
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text('learning-approach'),
      //   backgroundColor: Color(0xFF5364F4),
      // ),
    );
  }
}
