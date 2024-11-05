import 'package:blade/models/membership_model.dart';
import 'package:blade/models/response_model.dart';
import 'package:blade/repositories/manga_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  bool isLoading = true;
  List<MembershipModel> memberships = [];

  fetch() async {
    isLoading = true;
    setStates();
    ResponseModel response = await MangaRepositories().memberships();
    if (response.status == 200 && response.success == true) {
      memberships.addAll(List<MembershipModel>.from(
          response.data.map((x) => MembershipModel.fromJson(x))));
      isLoading = false;
      setStates();
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
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
        title: const Text("Үйлчилгээний эрх"),
      ),
      body: isLoading
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: memberships.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed('/membership-detail',
                        arguments: [memberships[index]]);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          memberships[index].title ?? "",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "${memberships[index].price}₮",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
