import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/images/logo.png',
                width: 120.w,
                height: 120.w,
              ),
              SizedBox(height: 40.h),
              
              // 欢迎文本
              Text(
                '欢迎使用金豆荚便民服务',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                '请选择登录方式',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 40.h),

              // 错误消息
              Obx(() {
                if (controller.errorMessage.value.isNotEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Text(
                      controller.errorMessage.value,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.sp,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),

              // 社交登录按钮
              _buildSocialLoginButton(
                title: '使用Google账号登录',
                icon: 'assets/icons/google.png',
                onTap: () => controller.signInWithGoogle(),
              ),
              SizedBox(height: 15.h),
              
              _buildSocialLoginButton(
                title: '使用Apple ID登录',
                icon: 'assets/icons/apple.png',
                onTap: () => controller.signInWithApple(),
              ),
              SizedBox(height: 15.h),
              
              _buildSocialLoginButton(
                title: '使用微信登录',
                icon: 'assets/icons/wechat.png',
                onTap: () => controller.signInWithWeChat(),
              ),

              // 加载指示器
              Obx(() {
                if (controller.isLoading.value) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: const CircularProgressIndicator(),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 24.w,
              height: 24.w,
            ),
            SizedBox(width: 10.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 