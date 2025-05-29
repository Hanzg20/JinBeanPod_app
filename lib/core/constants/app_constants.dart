class AppConstants {
  static const String appName = '金豆荚便民';
  static const String appNameShort = '金豆荚';
  
  // 应用版本信息
  static const String version = '1.0.0';
  
  // 底部导航栏标题
  static const Map<String, String> bottomNavTitles = {
    'home': 'nav_home',
    'services': 'nav_services',
    'profile': 'nav_profile',
  };
  
  // 底部导航栏图标
  static const Map<String, String> bottomNavIcons = {
    'home': 'home',
    'services': 'apps',
    'profile': 'person',
  };
  
  // 服务类别
  static const List<Map<String, String>> serviceCategories = [
    {'label': '家政服务', 'icon': 'cleaning'},
    {'label': '维修服务', 'icon': 'repair'},
    {'label': '搬家服务', 'icon': 'moving'},
    {'label': '教育培训', 'icon': 'education'},
    {'label': '医疗保健', 'icon': 'medical'},
    {'label': '快递服务', 'icon': 'express'},
    {'label': '餐饮外卖', 'icon': 'food'},
    {'label': '更多服务', 'icon': 'more'},
  ];
} 