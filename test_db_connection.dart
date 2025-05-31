import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // 初始化 Supabase
  await Supabase.initialize(
    url: 'http://127.0.0.1:54321',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0',
  );

  final supabase = Supabase.instance.client;

  try {
    // 测试查询用户资料
    print('\n测试查询用户资料:');
    final profiles = await supabase
        .from('profiles')
        .select()
        .order('created_at');
    print('找到 ${profiles.length} 个用户资料:');
    for (var profile in profiles) {
      print('- ${profile['display_name']} (${profile['email']})');
    }

    // 测试查询用户设置
    print('\n测试查询用户设置:');
    final settings = await supabase
        .from('user_settings')
        .select()
        .order('created_at');
    print('找到 ${settings.length} 个用户设置:');
    for (var setting in settings) {
      print('- 主题: ${setting['theme']}, 语言: ${setting['language']}');
    }

    // 测试查询地址
    print('\n测试查询地址:');
    final addresses = await supabase
        .from('addresses')
        .select()
        .order('created_at');
    print('找到 ${addresses.length} 个地址:');
    for (var address in addresses) {
      print('- ${address['address_line1']}, ${address['city']}, ${address['state']}');
    }

    // 测试查询服务商资料
    print('\n测试查询服务商资料:');
    final providers = await supabase
        .from('provider_profiles')
        .select()
        .order('created_at');
    print('找到 ${providers.length} 个服务商资料:');
    for (var provider in providers) {
      print('- ${provider['business_name']} (${provider['verification_status']})');
    }

    print('\n数据库连接测试完成！');
  } catch (e) {
    print('错误: $e');
  }
} 