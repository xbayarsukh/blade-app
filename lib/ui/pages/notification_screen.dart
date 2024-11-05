import 'package:blade/models/notification_model.dart';
import 'package:blade/models/response_model.dart';
import 'package:blade/repositories/about_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications = [];
  bool isLoading = true;

  fetchData() async {
    isLoading = true;
    setStates();
    ResponseModel response = await AboutRepositories().notifications();
    if (response.status == 200 && response.success == true) {
      notifications.addAll(List<NotificationModel>.from(
          response.data.map((x) => NotificationModel.fromJson(x))));
      isLoading = false;
      setStates();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  setStates() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Мэдэгдэл"),
      ),
      body: isLoading
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: notifications.length,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.notifications).padding(right: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notifications[index].title ?? "",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              notifications[index].description ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(
                              notifications[index].createdAt ?? DateTime.now()),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
