import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/social_controller.dart';
import '../widgets/community_card.dart';
import '../widgets/event_card.dart';

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SocialController());

    return Scaffold(
      appBar: AppBar(
        title: Text('nav_social'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: 实现搜索功能
            },
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: controller.loadData,
                child: ListView(
                  padding: EdgeInsets.all(16.w),
                  children: [
                    _buildCommunitiesSection(controller),
                    SizedBox(height: 20.h),
                    _buildUpcomingEventsSection(controller),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 创建新活动
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCommunitiesSection(SocialController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'community'.tr,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: 查看全部社区
              },
              child: Text(
                'view_all'.tr,
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.communities.length,
            itemBuilder: (context, index) {
              final community = controller.communities[index];
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: CommunityCard(
                  community: community,
                  onJoin: () => controller.joinCommunity(community.id),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingEventsSection(SocialController controller) {
    final upcomingEvents = controller.getUpcomingEvents();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'upcoming_events'.tr,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: 查看全部活动
              },
              child: Text(
                'view_all'.tr,
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: upcomingEvents.length,
          itemBuilder: (context, index) {
            final event = upcomingEvents[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: EventCard(
                event: event,
                onJoin: () => controller.joinEvent(event.id),
              ),
            );
          },
        ),
      ],
    );
  }
} 