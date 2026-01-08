import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  static String name = "notifications-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("notifications.title".tr(), style: TextTheme.of(context).titleMedium),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => Dismissible(
          key: Key(index.toString()),
          onDismissed: (direction) => () {},
          child: ListTile(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            tileColor: Colors.white,
            subtitle: Text(
              "notifications.sample_message".tr(),
            ),
            trailing: Text("notifications.time_ago".tr()),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.notifications, color: Colors.orange),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 5),
        itemCount: 10,
      ),
    );
  }
}