import 'package:get/get.dart';
import '../models/community.dart';
import '../models/event.dart';

class SocialController extends GetxController {
  final RxList<Community> communities = <Community>[].obs;
  final RxList<Event> events = <Event>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    try {
      // TODO: 从API加载数据
      // 模拟数据
      communities.value = [
        Community(
          id: '1',
          name: '北美华人社区',
          description: '欢迎所有北美华人加入我们的社区，这里有最新的生活资讯和互助信息。',
          image: 'assets/images/community1.jpg',
          membersCount: 1200,
          postsCount: 350,
          tags: ['华人', '互助', '生活'],
          location: 'North America',
        ),
        Community(
          id: '2',
          name: '亲子活动群',
          description: '组织各类亲子活动，让孩子们快乐成长。',
          image: 'assets/images/community2.jpg',
          membersCount: 800,
          postsCount: 220,
          tags: ['亲子', '教育', '活动'],
          location: 'Local',
        ),
      ];

      events.value = [
        Event(
          id: '1',
          title: '周末野餐会',
          description: '让我们一起享受美好的周末时光，带上美食来野餐吧！',
          image: 'assets/images/event1.jpg',
          startTime: DateTime.now().add(const Duration(days: 2)),
          endTime: DateTime.now().add(const Duration(days: 2, hours: 3)),
          location: 'Central Park',
          participantsCount: 25,
          maxParticipants: 50,
          organizerId: '1',
          organizerName: '社区管理员',
          communityId: '1',
          communityName: '北美华人社区',
          tags: ['聚会', '美食', '户外'],
          isFree: true,
        ),
        Event(
          id: '2',
          title: '中秋晚会',
          description: '一起庆祝中秋节，品尝月饼，欣赏文艺表演。',
          image: 'assets/images/event2.jpg',
          startTime: DateTime.now().add(const Duration(days: 5)),
          endTime: DateTime.now().add(const Duration(days: 5, hours: 4)),
          location: 'Community Center',
          participantsCount: 80,
          maxParticipants: 100,
          organizerId: '1',
          organizerName: '文化委员会',
          communityId: '1',
          communityName: '北美华人社区',
          tags: ['节日', '文化', '表演'],
          isFree: false,
          price: 15.0,
        ),
      ];
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load data',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> joinCommunity(String communityId) async {
    try {
      // TODO: 调用API加入社区
      final index = communities.indexWhere((c) => c.id == communityId);
      if (index != -1) {
        final community = communities[index];
        communities[index] = Community(
          id: community.id,
          name: community.name,
          description: community.description,
          image: community.image,
          membersCount: community.membersCount + 1,
          postsCount: community.postsCount,
          isJoined: true,
          tags: community.tags,
          location: community.location,
        );
        Get.snackbar(
          'Success',
          'Successfully joined the community',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to join community',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> joinEvent(String eventId) async {
    try {
      // TODO: 调用API参加活动
      final index = events.indexWhere((e) => e.id == eventId);
      if (index != -1) {
        final event = events[index];
        if (event.isFull) {
          Get.snackbar(
            'Error',
            'Event is full',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
        events[index] = Event(
          id: event.id,
          title: event.title,
          description: event.description,
          image: event.image,
          startTime: event.startTime,
          endTime: event.endTime,
          location: event.location,
          participantsCount: event.participantsCount + 1,
          maxParticipants: event.maxParticipants,
          isJoined: true,
          organizerId: event.organizerId,
          organizerName: event.organizerName,
          communityId: event.communityId,
          communityName: event.communityName,
          tags: event.tags,
          isFree: event.isFree,
          price: event.price,
        );
        Get.snackbar(
          'Success',
          'Successfully joined the event',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to join event',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  List<Event> getUpcomingEvents() {
    return events.where((event) => event.isUpcoming).toList();
  }

  List<Event> getCommunityEvents(String communityId) {
    return events.where((event) => event.communityId == communityId).toList();
  }
} 