import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'avatar_edit_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? avatarUrl;
  String username = '未设置用户名';
  String email = '未设置邮箱';

  Future<void> _editAvatar() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AvatarEditPage(
          currentAvatarUrl: avatarUrl,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        avatarUrl = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人资料'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: avatarUrl != null
                        ? CachedNetworkImageProvider(avatarUrl!)
                        : null,
                    child: avatarUrl == null
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: IconButton(
                        icon: const Icon(Icons.edit, size: 18),
                        color: Colors.white,
                        onPressed: _editAvatar,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('用户名'),
              subtitle: Text(username),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: 实现用户名编辑功能
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('邮箱'),
              subtitle: Text(email),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: 实现邮箱编辑功能
              },
            ),
          ],
        ),
      ),
    );
  }
} 