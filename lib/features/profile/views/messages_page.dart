import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('messages'.tr),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'system_messages'.tr),
              Tab(text: 'service_messages'.tr),
              Tab(text: 'activity_messages'.tr),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMessageList(context, MessageType.system),
            _buildMessageList(context, MessageType.service),
            _buildMessageList(context, MessageType.activity),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList(BuildContext context, MessageType type) {
    // 模拟消息数据
    final messages = _getMessages(type);

    if (messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: Theme.of(context).hintColor,
            ),
            const SizedBox(height: 16),
            Text(
              'no_messages'.tr,
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final message = messages[index];
        return _buildMessageItem(context, message);
      },
    );
  }

  Widget _buildMessageItem(BuildContext context, Message message) {
    return InkWell(
      onTap: () {
        // TODO: 跳转到消息详情页面
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                message.type.icon,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        message.time,
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.content,
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (message.unread) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'unread'.tr,
                        style: TextStyle(
                          color: Colors.red[400],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Message> _getMessages(MessageType type) {
    switch (type) {
      case MessageType.system:
        return [
          Message(
            type: MessageType.system,
            title: 'system_update'.tr,
            content: 'system_update_content'.tr,
            time: '10:30',
            unread: true,
          ),
          Message(
            type: MessageType.system,
            title: 'account_security'.tr,
            content: 'account_security_content'.tr,
            time: '昨天',
            unread: false,
          ),
        ];
      case MessageType.service:
        return [
          Message(
            type: MessageType.service,
            title: 'service_reminder'.tr,
            content: 'service_reminder_content'.tr,
            time: '09:15',
            unread: true,
          ),
          Message(
            type: MessageType.service,
            title: 'order_complete'.tr,
            content: 'order_complete_content'.tr,
            time: '昨天',
            unread: false,
          ),
        ];
      case MessageType.activity:
        return [
          Message(
            type: MessageType.activity,
            title: 'new_year_promotion'.tr,
            content: 'new_year_promotion_content'.tr,
            time: '11:00',
            unread: true,
          ),
        ];
    }
  }
}

enum MessageType {
  system(Icons.info_outline),
  service(Icons.support_agent),
  activity(Icons.local_activity);

  const MessageType(this.icon);
  final IconData icon;
}

class Message {
  final MessageType type;
  final String title;
  final String content;
  final String time;
  final bool unread;

  Message({
    required this.type,
    required this.title,
    required this.content,
    required this.time,
    required this.unread,
  });
} 