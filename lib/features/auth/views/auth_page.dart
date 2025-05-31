import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/controllers/auth_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                  '欢迎使用金豆荚',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 10.h),
                
                Text(
                  '一站式便民服务平台',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 40.h),

                // 错误消息
                Obx(() {
                  if (controller.errorMessage.isNotEmpty) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                      margin: EdgeInsets.only(bottom: 20.h),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        controller.errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),

                // 社交登录按钮
                _buildSocialLoginButton(
                  title: '使用微信登录',
                  icon: Icons.wechat,
                  color: const Color(0xFF07C160),
                  onTap: () => controller.signInWithWeChat(),
                ),
                
                SizedBox(height: 16.h),
                
                _buildSocialLoginButton(
                  title: '使用Apple账号登录',
                  icon: Icons.apple,
                  color: Colors.black,
                  onTap: () => controller.signInWithApple(),
                ),
                
                SizedBox(height: 16.h),
                
                _buildSocialLoginButton(
                  title: '使用Google账号登录',
                  icon: Icons.g_mobiledata,
                  color: Colors.blue,
                  onTap: () => controller.signInWithGoogle(),
                ),

                SizedBox(height: 30.h),

                // 分割线
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[300])),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        '或',
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

                // 邮箱登录/注册按钮
                ElevatedButton(
                  onPressed: () => Get.toNamed('/auth/email'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    '使用邮箱登录/注册',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),

                SizedBox(height: 16.h),

                // 游客模式
                TextButton(
                  onPressed: () => controller.continueAsGuest(),
                  child: Text(
                    '游客模式',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                // 用户协议和隐私政策
                Text(
                  '登录即代表同意《用户协议》和《隐私政策》',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),

                // 加载指示器
                Obx(() {
                  if (controller.isLoading) {
                    return Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }
} 