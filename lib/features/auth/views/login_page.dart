import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/controllers/auth_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/routes/app_pages.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50.h),
              
              // Logo
              Center(
                child: Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.spa,
                    size: 60.w,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              
              SizedBox(height: 30.h),
              
              // 欢迎文本
              Text(
                'welcome'.tr,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 10.h),
              
              Text(
                'platform_desc'.tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 50.h),
              
              // 邮箱登录按钮
              ElevatedButton(
                onPressed: () => Get.toNamed(Routes.EMAIL_AUTH),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.email),
                    SizedBox(width: 10.w),
                    Text('email_login'.tr),
                  ],
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // 社交登录选项
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSocialLoginButton(
                    icon: Icons.g_mobiledata,
                    label: 'google_login'.tr,
                    onTap: controller.signInWithGoogle,
                  ),
                  _buildSocialLoginButton(
                    icon: Icons.apple,
                    label: 'apple_login'.tr,
                    onTap: controller.signInWithApple,
                  ),
                  _buildSocialLoginButton(
                    icon: Icons.wechat,
                    label: 'wechat_login'.tr,
                    onTap: controller.signInWithWeChat,
                  ),
                ],
              ),
              
              SizedBox(height: 30.h),
              
              // 分割线
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'or'.tr,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[300])),
                ],
              ),
              
              SizedBox(height: 30.h),
              
              // 游客模式按钮
              OutlinedButton(
                onPressed: controller.continueAsGuest,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('guest_mode'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 24.w,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _handleLoginSuccess() {
    Get.offAllNamed(Routes.MAIN);
  }
} 