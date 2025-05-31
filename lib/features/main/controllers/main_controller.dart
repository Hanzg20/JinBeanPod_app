import 'package:get/get.dart';
import '../../home/views/home_page.dart';
import '../../jindou/views/jindou_page.dart';
import '../../services/views/services_page.dart';
import '../../profile/views/profile_page.dart';
import '../../community/views/community_page.dart';

class MainController extends GetxController {
  final currentIndex = 0.obs;
  
  final pages = [
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