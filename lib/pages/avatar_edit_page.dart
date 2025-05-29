import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AvatarEditPage extends StatefulWidget {
  final String? currentAvatarUrl;

  const AvatarEditPage({super.key, this.currentAvatarUrl});

  @override
  State<AvatarEditPage> createState() => _AvatarEditPageState();
}

class _AvatarEditPageState extends State<AvatarEditPage> {
  File? _imageFile;
  final _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('选择图片失败')),
      );
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: 实现图片上传功能
      await Future.delayed(const Duration(seconds: 2)); // 模拟上传延迟
      Navigator.pop(context, 'https://example.com/avatar.jpg'); // 返回模拟的URL
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('上传失败')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('选择图片来源'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('拍照'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('从相册选择'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? backgroundImage;
    if (_imageFile != null) {
      backgroundImage = FileImage(_imageFile!);
    } else if (widget.currentAvatarUrl != null) {
      backgroundImage = CachedNetworkImageProvider(widget.currentAvatarUrl!);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('修改头像'),
        actions: [
          if (_imageFile != null)
            TextButton(
              onPressed: _isLoading ? null : _uploadImage,
              child: _isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('上传'),
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.grey[200],
              backgroundImage: backgroundImage,
              child: backgroundImage == null
                  ? const Icon(Icons.person, size: 100, color: Colors.grey)
                  : null,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _showImageSourceDialog,
              icon: const Icon(Icons.add_a_photo),
              label: const Text('选择图片'),
            ),
          ],
        ),
      ),
    );
  }
} 