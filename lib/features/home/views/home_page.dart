import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../widgets/banner_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  IconData _getServiceIcon(String category) {
    switch (category) {
      case '家政保洁':
        return Icons.cleaning_services;
      case '家居维修':
        return Icons.handyman;
      case '搬家服务':
        return Icons.local_shipping;
      case '教育培训':
        return Icons.school;
      case '医疗保健':
        return Icons.local_hospital;
      case '快递服务':
        return Icons.local_post_office;
      case '餐饮外卖':
        return Icons.restaurant;
      case '更多服务':
        return Icons.more_horiz;
      default:
        return Icons.miscellaneous_services;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app_name'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // TODO: 跳转到通知页面
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: 实现下拉刷新
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // 搜索栏
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Theme.of(context).hintColor),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'search_hint'.tr,
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Theme.of(context).hintColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 轮播图
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 160,
                child: BannerCarousel(),
              ),
            ),
            const SizedBox(height: 24.0),
            // 服务分类
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'service_categories'.tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 16.0),
            GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 0.85,
              children: AppConstants.serviceCategories.map((category) {
                return InkWell(
                  onTap: () {
                    // TODO: 跳转到对应服务类别页面
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Icon(
                          _getServiceIcon(category['label']!),
                          color: Theme.of(context).primaryColor,
                          size: 32.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        category['label']!.tr,
                        style: const TextStyle(fontSize: 12.0),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24.0),
            // 热门服务
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'popular_services'.tr,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: 跳转到全部服务页面
                    },
                    child: Row(
                      children: [
                        Text(
                          'more_services'.tr,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 56.0,
                          height: 56.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Icon(
                            Icons.cleaning_services,
                            color: Theme.of(context).primaryColor,
                            size: 32.0,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '服务项目 ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                '服务描述 ${index + 1}',
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 16.0,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    '4.${9 - index}',
                                    style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Icon(
                                    Icons.access_time,
                                    size: 16.0,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    '${30 + index * 10}分钟',
                                    style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('book_now'.tr),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
} 