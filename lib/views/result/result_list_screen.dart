import 'package:flutter/material.dart';
import 'package:webspark_test_task/configs/app_strings.dart';
import 'package:webspark_test_task/views/widgets/custom_appbar.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: Text(AppStrings.resultListScreen)),
      body: Center(child: Text(AppStrings.resultListScreen)),
    );
  }
}