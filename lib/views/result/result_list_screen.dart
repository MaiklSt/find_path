import 'package:flutter/material.dart';
import 'package:webspark_test_task/configs/app_strings.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text(AppStrings.resultListScreen)),
    );
  }
}