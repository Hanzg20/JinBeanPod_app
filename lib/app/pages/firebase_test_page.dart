import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class FirebaseTestPage extends StatefulWidget {
  const FirebaseTestPage({super.key});

  @override
  State<FirebaseTestPage> createState() => _FirebaseTestPageState();
}

class _FirebaseTestPageState extends State<FirebaseTestPage> {
  final AuthController _authController = Get.find<AuthController>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _testResult = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _testFirebaseConnection() async {
    setState(() {
      _isLoading = true;
      _testResult = '正在测试 Firebase 连接...\n';
    });

    try {
      // 测试 Firebase Auth
      _testResult += '\n测试 Firebase Auth:\n';
      final auth = FirebaseAuth.instance;
      _testResult += '- 当前用户: ${auth.currentUser?.email ?? '未登录'}\n';
      _testResult += '- 语言设置: ${auth.languageCode}\n';

      // 测试 Firestore
      _testResult += '\n测试 Firestore:\n';
      final testDoc = await FirebaseFirestore.instance
          .collection('test')
          .doc('connection_test')
          .set({
        'timestamp': FieldValue.serverTimestamp(),
        'test': true,
      });
      _testResult += '- Firestore 写入测试成功\n';

      // 读取测试
      final testRead = await FirebaseFirestore.instance
          .collection('test')
          .doc('connection_test')
          .get();
      _testResult += '- Firestore 读取测试成功\n';
      _testResult += '- 文档数据: ${testRead.data()}\n';

    } catch (e) {
      _testResult += '\n错误:\n$e\n';
      if (e is FirebaseAuthException) {
        _testResult += '\nFirebase Auth 错误:\n';
        _testResult += '- 错误代码: ${e.code}\n';
        _testResult += '- 错误信息: ${e.message}\n';
      }
      if (e is FirebaseException) {
        _testResult += '\nFirebase 错误:\n';
        _testResult += '- 错误代码: ${e.code}\n';
        _testResult += '- 错误信息: ${e.message}\n';
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _testResult = '请输入邮箱和密码';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _testResult = '正在测试登录...\n';
    });

    try {
      await _authController.loginWithEmail(
        email: _emailController.text,
        password: _passwordController.text,
      );

      setState(() {
        _testResult += '\n登录测试完成:\n';
        _testResult += '- 当前用户: ${FirebaseAuth.instance.currentUser?.email ?? '未登录'}\n';
        _testResult += '- 错误信息: ${_authController.errorMessage.value}\n';
      });
    } catch (e) {
      setState(() {
        _testResult += '\n登录测试出错:\n$e\n';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase 连接测试'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '邮箱',
                hintText: '请输入邮箱',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: '密码',
                hintText: '请输入密码',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _testLogin,
              child: const Text('测试登录'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _testFirebaseConnection,
              child: const Text('测试 Firebase 连接'),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '测试结果:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    Text(_testResult),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 