import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/views/home_page.dart';
import '../../services/views/services_page.dart';
import '../../community/views/community_page.dart';
import '../../jindou/views/jindou_page.dart';
import '../../profile/views/profile_page.dart';
import '../controllers/main_controller.dart';

class MainPage extends GetView<MainController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: controller.pages,
      )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changePage,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: '服务',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: '金豆圈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '社区',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      )),
    );
  }
} 