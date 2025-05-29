import 'package:get/get.dart';
import '../models/service_request.dart';
import '../models/service_order.dart';

class ServiceRequestController extends GetxController {
  final RxList<ServiceRequest> requests = <ServiceRequest>[].obs;
  final RxList<ServiceOrder> orders = <ServiceOrder>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserRequests();
  }

  // 加载用户的服务需求
  Future<void> loadUserRequests() async {
    isLoading.value = true;
    try {
      // TODO: 从API加载数据
      // 模拟数据
      await Future.delayed(const Duration(seconds: 1));
      requests.value = [
        ServiceRequest(
          id: '1',
          userId: 'user1',
          title: '居家清洁服务',
          description: '需要对120平米的房屋进行深度清洁，包括地板、窗户、厨房和卫生间。',
          categories: ['清洁', '家政'],
          location: '多伦多',
          expectedStartDate: DateTime.now().add(const Duration(days: 2)),
          expectedEndDate: DateTime.now().add(const Duration(days: 2, hours: 4)),
          budget: 150.0,
          status: ServiceRequestStatus.pending,
          createdAt: DateTime.now(),
        ),
        ServiceRequest(
          id: '2',
          userId: 'user1',
          title: '搬家帮助',
          description: '从市中心搬到北约克，需要2-3人帮忙搬运家具和大件物品。',
          categories: ['搬家', '体力工'],
          location: '多伦多',
          expectedStartDate: DateTime.now().add(const Duration(days: 5)),
          expectedEndDate: DateTime.now().add(const Duration(days: 5, hours: 6)),
          budget: 300.0,
          status: ServiceRequestStatus.approved,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load service requests',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // 创建新的服务需求
  Future<bool> createServiceRequest(ServiceRequest request) async {
    try {
      // TODO: 调用API创建服务需求
      await Future.delayed(const Duration(seconds: 1));
      requests.add(request);
      Get.snackbar(
        'Success',
        'request_created_successfully'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'failed_to_create_request'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  // 取消服务需求
  Future<bool> cancelServiceRequest(String requestId) async {
    try {
      // TODO: 调用API取消服务需求
      await Future.delayed(const Duration(seconds: 1));
      final index = requests.indexWhere((r) => r.id == requestId);
      if (index != -1) {
        final request = requests[index];
        requests[index] = ServiceRequest(
          id: request.id,
          userId: request.userId,
          title: request.title,
          description: request.description,
          categories: request.categories,
          location: request.location,
          expectedStartDate: request.expectedStartDate,
          expectedEndDate: request.expectedEndDate,
          budget: request.budget,
          status: ServiceRequestStatus.cancelled,
          createdAt: request.createdAt,
        );
        Get.snackbar(
          'Success',
          'request_cancelled_successfully'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar(
        'Error',
        'failed_to_cancel_request'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  // 加载用户的服务订单
  Future<void> loadUserOrders() async {
    isLoading.value = true;
    try {
      // TODO: 从API加载数据
      // 模拟数据
      await Future.delayed(const Duration(seconds: 1));
      orders.value = [
        ServiceOrder(
          id: '1',
          requestId: '2',
          userId: 'user1',
          title: '搬家帮助',
          description: '从市中心搬到北约克，需要2-3人帮忙搬运家具和大件物品。',
          categories: ['搬家', '体力工'],
          location: '多伦多',
          startDate: DateTime.now().add(const Duration(days: 5)),
          endDate: DateTime.now().add(const Duration(days: 5, hours: 6)),
          budget: 300.0,
          status: ServiceOrderStatus.pending,
          createdAt: DateTime.now(),
          progress: [
            ServiceOrderProgress(
              id: '1',
              orderId: '1',
              content: '订单已创建，等待分配服务人员',
              timestamp: DateTime.now(),
              updatedBy: 'system',
            ),
          ],
        ),
      ];
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load service orders',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // 获取订单进度
  List<ServiceOrderProgress>? getOrderProgress(String orderId) {
    final order = orders.firstWhereOrNull((o) => o.id == orderId);
    return order?.progress;
  }
} 