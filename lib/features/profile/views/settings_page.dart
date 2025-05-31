import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controllers/settings_controller.dart';
import '../../../core/controllers/language_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    final languageController = Get.find<LanguageController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // 账号设置
          _buildSectionHeader('settings'.tr),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text('profile_settings_title'.tr),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 跳转到个人资料设置页面
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: Text('security_settings_title'.tr),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 跳转到安全设置页面
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text('privacy_settings_title'.tr),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 跳转到隐私设置页面
            },
          ),

          // 通用设置
          _buildSectionHeader('settings'.tr),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('language_settings_title'.tr),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => Text(
                      languageController.getCurrentLanguageName(),
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                      ),
                    )),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: () {
              Get.bottomSheet(
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      ...languageController.languages.map((lang) => ListTile(
                            title: Text(lang['name'] as String),
                            trailing: Obx(() => languageController.currentLanguage.value == lang['code']
                                ? Icon(
                                    Icons.check,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : const SizedBox.shrink()),
                            onTap: () {
                              languageController.updateLanguage(lang['code'] as String);
                              Get.back();
                            },
                          )).toList(),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text('theme_mode'.tr),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => Text(
                      settingsController.isDarkMode
                          ? 'dark_mode'.tr
                          : 'light_mode'.tr,
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                      ),
                    )),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: () {
              Get.bottomSheet(
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.wb_sunny),
                        title: Text('light_mode'.tr),
                        trailing: Obx(() => settingsController.themeMode == ThemeMode.light
                            ? Icon(
                                Icons.check,
                                color: Theme.of(context).primaryColor,
                              )
                            : const SizedBox.shrink()),
                        onTap: () {
                          settingsController.updateTheme('light');
                          Get.back();
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.nightlight_round),
                        title: Text('dark_mode'.tr),
                        trailing: Obx(() => settingsController.themeMode == ThemeMode.dark
                            ? Icon(
                                Icons.check,
                                color: Theme.of(context).primaryColor,
                              )
                            : const SizedBox.shrink()),
                        onTap: () {
                          settingsController.updateTheme('dark');
                          Get.back();
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings_system_daydream),
                        title: Text('system_mode'.tr),
                        trailing: Obx(() => settingsController.themeMode == ThemeMode.system
                            ? Icon(
                                Icons.check,
                                color: Theme.of(context).primaryColor,
                              )
                            : const SizedBox.shrink()),
                        onTap: () {
                          settingsController.updateTheme('system');
                          Get.back();
                        },
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: Text('notification_settings_title'.tr),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 跳转到通知设置页面
            },
          ),

          // 其他设置
          _buildSectionHeader('other_settings_title'.tr),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: Text('help_and_feedback'.tr),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 跳转到帮助与反馈页面
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text('about'.tr),
            trailing: Text(
              'v1.0.0',
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
            onTap: () {
              // TODO: 跳转到关于页面
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }
} 