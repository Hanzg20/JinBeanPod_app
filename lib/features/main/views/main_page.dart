import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/views/home_page.dart';
import '../../services/views/services_page.dart';
import '../../community/views/community_page.dart';
import '../../jindou/views/jindou_page.dart';
import '../../profile/views/profile_page.dart';
import '../controllers/main_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());

    final pages = [
      const HomePage(),
      const ServicesPage(),
      const CommunityPage(),
      const JinDouPage(),
      const ProfilePage(),
    ];

    return Obx(
      () => Scaffold(
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'nav_home'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.apps),
              label: 'nav_services'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.people),
              label: 'nav_community'.tr,
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.monetization_on_outlined),
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              activeIcon: Stack(
                children: [
                  Icon(
                    Icons.monetization_on,
                    color: Theme.of(context).primaryColor,
                  ),
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              label: 'nav_jindou'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'nav_profile'.tr,
            ),
          ],
        ),
      ),
    );
  }
} 