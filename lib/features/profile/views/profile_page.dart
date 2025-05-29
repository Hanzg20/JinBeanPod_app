import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controllers/auth_controller.dart';
import 'messages_page.dart';
import 'settings_page.dart';
import 'my_demands_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        title: Text('nav_profile'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              Get.to(() => const MessagesPage());
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // 用户信息卡片
          _buildUserInfoCard(context),
          const SizedBox(height: 16),
          // 用户数据统计
          _buildUserStats(context),
          const SizedBox(height: 16),
          // 我的订单
          _buildOrderSection(context),
          const SizedBox(height: 16),
          // 我的服务
          _buildServiceSection(context),
          const SizedBox(height: 16),
          // 金豆钱包
          _buildWalletSection(context),
          const SizedBox(height: 16),
          // 其他功能
          _buildOtherSection(context),
          const SizedBox(height: 20),
          // 退出登录按钮
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                authController.logout();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: Colors.red[400],
                foregroundColor: Colors.white,
              ),
              child: Text('logout'.tr),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildUserInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'user_name'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'user_id'.tr,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'vip_level'.tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  // TODO: 跳转到编辑个人资料页面
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserStats(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(context, 'jindou_balance'.tr, '1,234'),
          _buildStatItem(context, 'coupons'.tr, '5'),
          _buildStatItem(context, 'favorites'.tr, '8'),
          _buildStatItem(context, 'following'.tr, '12'),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).hintColor,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'my_orders'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: TextButton(
              onPressed: () {
                // TODO: 跳转到全部订单页面
              },
              child: Text('view_all'.tr),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildOrderItem(context, Icons.payment, 'pending_payment'.tr),
                _buildOrderItem(context, Icons.access_time, 'pending_service'.tr),
                _buildOrderItem(context, Icons.star_border, 'pending_review'.tr),
                _buildOrderItem(context, Icons.refresh, 'refund'.tr),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, IconData icon, String label) {
    return InkWell(
      onTap: () {
        // TODO: 跳转到对应订单列表页面
      },
      child: Column(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'my_services'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _buildServiceItem(context, Icons.location_on, 'address'.tr),
              _buildServiceItem(context, Icons.support_agent, 'customer_service'.tr),
              _buildServiceItem(context, Icons.help_outline, 'help_center'.tr),
              _buildServiceItem(context, Icons.feedback, 'feedback'.tr),
              _buildServiceItem(context, Icons.local_activity, 'activities'.tr),
              _buildServiceItem(context, Icons.card_giftcard, 'invite'.tr),
              _buildServiceItem(context, Icons.history, 'history'.tr),
              _buildServiceItem(context, Icons.assignment_outlined, 'my_demands'.tr),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, IconData icon, String label) {
    return InkWell(
      onTap: () {
        // 根据不同的服务项跳转到对应页面
        switch (label) {
          case String l when l == 'my_demands'.tr:
            Get.to(() => const MyDemandsPage());
            break;
          case String l when l == 'address'.tr:
            // TODO: 跳转到地址管理页面
            break;
          case String l when l == 'customer_service'.tr:
            // TODO: 跳转到客服中心页面
            break;
          case String l when l == 'help_center'.tr:
            // TODO: 跳转到帮助中心页面
            break;
          case String l when l == 'feedback'.tr:
            // TODO: 跳转到意见反馈页面
            break;
          case String l when l == 'activities'.tr:
            // TODO: 跳转到活动中心页面
            break;
          case String l when l == 'invite'.tr:
            // TODO: 跳转到邀请好友页面
            break;
          case String l when l == 'history'.tr:
            // TODO: 跳转到历史记录页面
            break;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildWalletSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: Text('jindou_wallet'.tr),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 跳转到金豆钱包页面
            },
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'jindou_balance'.tr,
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '1,234',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: 跳转到充值页面
                  },
                  child: Text('recharge'.tr),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text('settings'.tr),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Get.to(() => const SettingsPage());
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: Text('help_and_feedback'.tr),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 跳转到帮助与反馈页面
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text('about'.tr),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 跳转到关于页面
            },
          ),
        ],
      ),
    );
  }
} 