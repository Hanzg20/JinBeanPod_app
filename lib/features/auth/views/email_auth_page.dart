import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/controllers/auth_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailAuthPage extends StatelessWidget {
  const EmailAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final isLogin = true.obs;

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(isLogin.value ? '登录' : '注册')),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30.h),
              
              // 切换登录/注册
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => isLogin.value = true,
                    child: Text(
                      '登录',
                      style: TextStyle(
                        color: isLogin.value ? Theme.of(context).primaryColor : Colors.grey,
                        fontSize: 16.sp,
                        fontWeight: isLogin.value ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  TextButton(
                    onPressed: () => isLogin.value = false,
                    child: Text(
                      '注册',
                      style: TextStyle(
                        color: !isLogin.value ? Theme.of(context).primaryColor : Colors.grey,
                        fontSize: 16.sp,
                        fontWeight: !isLogin.value ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              )),
              
              SizedBox(height: 30.h),
              
              // 表单
              Obx(() => Column(
                children: [
                  // 邮箱输入框
                  TextField(
                    decoration: InputDecoration(
                      labelText: '邮箱',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => controller.email = value,
                  ),
                  
                  SizedBox(height: 16.h),
                  
                  // 密码输入框
                  TextField(
                    decoration: InputDecoration(
                      labelText: '密码',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    obscureText: true,
                    onChanged: (value) => controller.password = value,
                  ),
                  
                  SizedBox(height: 16.h),
                  
                  // 注册时显示确认密码
                  if (!isLogin.value)
                    TextField(
                      decoration: InputDecoration(
                        labelText: '确认密码',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      obscureText: true,
                      onChanged: (value) => controller.confirmPassword = value,
                    ),
                  
                  if (!isLogin.value) SizedBox(height: 16.h),
                  
                  // 注册时显示昵称
                  if (!isLogin.value)
                    TextField(
                      decoration: InputDecoration(
                        labelText: '昵称',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) => controller.displayName = value,
                    ),
                  
                  SizedBox(height: 24.h),
                  
                  // 提交按钮
                  Obx(() => ElevatedButton(
                    onPressed: controller.isLoading
                        ? null
                        : () {
                            if (isLogin.value) {
                              controller.loginWithEmail(
                                email: controller.email,
                                password: controller.password,
                              );
                            } else {
                              if (controller.password != controller.confirmPassword) {
                                Get.snackbar('错误', '两次输入的密码不一致');
                                return;
                              }
                              controller.registerWithEmail(
                                email: controller.email,
                                password: controller.password,
                                displayName: controller.displayName,
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: controller.isLoading
                        ? const CircularProgressIndicator()
                        : Text(isLogin.value ? '登录' : '注册'),
                  )),
                  
                  SizedBox(height: 16.h),
                  
                  // 忘记密码
                  if (isLogin.value)
                    TextButton(
                      onPressed: () {
                        // TODO: 跳转到重置密码页面
                      },
                      child: const Text('忘记密码？'),
                    ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
} 