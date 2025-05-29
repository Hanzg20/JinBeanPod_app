import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../features/home/views/home_page.dart';
import '../../features/services/views/services_page.dart';
import '../../features/jindou/views/jindou_page.dart';
import '../../features/community/views/community_page.dart';
import '../../features/profile/views/profile_page.dart';

class MainController extends GetxController {
  final RxInt currentIndex = 0.obs;

  final List<Widget> pages = [
    const HomePage(),
    const ServicesPage(),
    const JinDouPage(),
    const CommunityPage(),
    const ProfilePage(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
} 