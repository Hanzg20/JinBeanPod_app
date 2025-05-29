import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/home/views/home_page.dart';
import '../../features/services/views/services_page.dart';
import '../../features/social/views/social_page.dart';
import '../../features/profile/views/profile_page.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainNavigationController());

    return Scaffold(
      body: Obx(() => controller.pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 65.h,
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.changePage,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: 'nav_home'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.miscellaneous_services_outlined),
              selectedIcon: const Icon(Icons.miscellaneous_services),
              label: 'nav_services'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.people_outline),
              selectedIcon: const Icon(Icons.people),
              label: 'nav_social'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              selectedIcon: const Icon(Icons.person),
              label: 'nav_profile'.tr,
            ),
          ],
        ),
      ),
    );
  }
}

class MainNavigationController extends GetxController {
  final currentIndex = 0.obs;
  final pages = <Widget>[
    const HomePage(),
    const ServicesPage(),
    const SocialPage(),
    const ProfilePage(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
} 