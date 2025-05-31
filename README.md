# 金豆荚便民服务 App

金豆荚便民服务是一个基于 Flutter 开发的便民服务平台，旨在为用户提供便捷的生活服务预约和需求发布功能。

## 功能特点

- 多语言支持（中文/英文）
- 深色/浅色主题切换
- 个人中心
  - 用户信息管理
  - 订单管理
  - 金豆钱包
  - 服务管理
- 需求管理
  - 发布需求
  - 需求状态跟踪
  - 报价查看
- 消息中心
  - 系统消息
  - 服务消息
  - 活动消息

## 技术栈

- Flutter
- GetX（状态管理）
- GetStorage（本地存储）

## 开始使用

1. 确保已安装 Flutter 开发环境
2. 克隆项目
```bash
git clone https://github.com/yourusername/JinBeanPod_app.git
```
3. 安装依赖
```bash
flutter pub get
```
4. 运行项目
```bash
flutter run
```

## 项目结构

```
lib/
  ├── core/                 # 核心功能
  │   ├── controllers/     # 控制器
  │   └── translations/    # 多语言支持
  ├── features/            # 功能模块
  │   ├── main/           # 主页
  │   ├── profile/        # 个人中心
  │   └── services/       # 服务相关
  └── main.dart           # 入口文件
```

## 贡献指南

1. Fork 项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 版本历史

- 1.0.0
  - 初始版本
  - 基础功能实现

## 开源协议

本项目基于 MIT 协议开源 - 查看 [LICENSE](LICENSE) 文件了解更多细节
