import 'package:blade/models/response_model.dart';
import 'package:blade/repositories/about_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:styled_widget/styled_widget.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String aboutHtml = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    isLoading = true;
    setStates();
    ResponseModel response = await AboutRepositories().about();
    if (response.status == 200 && response.success == true) {
      aboutHtml = response.data;
      isLoading = false;
      setStates();
    }
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
        title: const Text("Бидний тухай"),
      ),
      body: isLoading
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : HtmlWidget(aboutHtml).padding(horizontal: 20, top: 10),
    );
  }
}
