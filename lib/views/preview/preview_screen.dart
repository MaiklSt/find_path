import 'package:flutter/material.dart';
import 'package:webspark_test_task/configs/app_strings.dart';
import 'package:webspark_test_task/models/calculation_result_model.dart';
import 'package:webspark_test_task/views/widgets/custom_appbar.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen(this.listCalculationResultModel, {super.key});

  final CalculationResultModel listCalculationResultModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: Text(AppStrings.previewScreen)),
      body: Container(),
    );
  }
}