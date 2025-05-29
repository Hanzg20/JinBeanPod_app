import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../controllers/service_request_controller.dart';
import '../models/service_order.dart';

class OrderDetailsPage extends StatelessWidget {
  final ServiceOrder order;

  const OrderDetailsPage({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ServiceRequestController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('order_details'.tr),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 订单状态卡片
            _buildStatusCard(),
            SizedBox(height: 16.h),

            // 订单基本信息
            _buildOrderInfo(),
            SizedBox(height: 16.h),

            // 服务详情
            _buildServiceDetails(),
            SizedBox(height: 16.h),

            // 订单进度
            _buildOrderProgress(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'order_status'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    order.statusText,
                    style: TextStyle(
                      color: _getStatusColor(),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if (order.providerId != null) ...[
              SizedBox(height: 12.h),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.person, color: Colors.grey[400]),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'service_provider'.tr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '服务人员姓名', // TODO: 替换为实际的服务人员姓名
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfo() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'order_info'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            _buildInfoRow('order_number'.tr, order.id),
            _buildInfoRow(
              'created_time'.tr,
              DateFormat('yyyy-MM-dd HH:mm').format(order.createdAt),
            ),
            _buildInfoRow(
              'service_time'.tr,
              '${DateFormat('MM/dd HH:mm').format(order.startDate)} - ${DateFormat('MM/dd HH:mm').format(order.endDate)}',
            ),
            _buildInfoRow('service_location'.tr, order.location),
            _buildInfoRow(
              'service_budget'.tr,
              '\$${order.budget.toStringAsFixed(2)}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceDetails() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'service_details'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              order.title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              order.description,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: order.categories.map((category) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderProgress(ServiceRequestController controller) {
    final progress = controller.getOrderProgress(order.id);
    if (progress == null || progress.isEmpty) {
      return const SizedBox();
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'order_progress'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: progress.length,
              itemBuilder: (context, index) {
                final item = progress[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          DateFormat('MM/dd HH:mm').format(item.timestamp),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.w),
                      padding: EdgeInsets.only(left: 18.w),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.h),
                          Text(
                            item.content,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          if (item.imageUrl != null) ...[
                            SizedBox(height: 8.h),
                            Container(
                              width: 200.w,
                              height: 120.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                image: DecorationImage(
                                  image: NetworkImage(item.imageUrl!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                          if (item.note != null) ...[
                            SizedBox(height: 8.h),
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                item.note!,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (order.status) {
      case ServiceOrderStatus.pending:
        return Colors.orange;
      case ServiceOrderStatus.assigned:
        return Colors.blue;
      case ServiceOrderStatus.inProgress:
        return Colors.green;
      case ServiceOrderStatus.completed:
        return Colors.teal;
      case ServiceOrderStatus.cancelled:
        return Colors.red;
      case ServiceOrderStatus.disputed:
        return Colors.deepOrange;
    }
  }
} 