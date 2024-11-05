import 'package:blade/models/membership_model.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class MembershipDetailScreen extends StatelessWidget {
  MembershipDetailScreen({required this.membershipModel, super.key});
  MembershipModel? membershipModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(membershipModel?.title ?? ""),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Text(
              "Үнэ: ${membershipModel?.price ?? 0}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ).padding(bottom: 20),
            Text(membershipModel?.description ?? "")
          ],
        ),
      ).padding(horizontal: 20, top: 20),
    );
  }
}
