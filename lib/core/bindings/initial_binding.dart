import 'package:get/get.dart';
import '../../app/controllers/auth_controller.dart';
import '../services/auth_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // 初始化服务
    Get.put(AuthService(), permanent: true);

    // 初始化控制器
    Get.put(AuthController(), permanent: true);
  }
} 