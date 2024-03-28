import 'package:flutter/material.dart';
import 'package:webspark_test_task/configs/app_strings.dart';
import 'package:webspark_test_task/models/calculation_result_model.dart';
import 'package:webspark_test_task/views/preview/preview_screen.dart';
import 'package:webspark_test_task/views/widgets/custom_appbar.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({super.key, required this.listCalculationResultModel});

  final List<CalculationResultModel> listCalculationResultModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: Text(AppStrings.resultListScreen)),
      body: ListView.separated(
        itemCount: listCalculationResultModel.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int columnIndex) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PreviewScreen(listCalculationResultModel[columnIndex])),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(listCalculationResultModel[columnIndex].calculatedPath.length, (rowIndex) {
                    if (rowIndex < listCalculationResultModel[columnIndex].calculatedPath.length - 1) {
                      return Text('(${listCalculationResultModel[columnIndex].calculatedPath[rowIndex].row},${listCalculationResultModel[columnIndex].calculatedPath[rowIndex].column})->');
                    }
                    return Text('(${listCalculationResultModel[columnIndex].calculatedPath[rowIndex].row},${listCalculationResultModel[columnIndex].calculatedPath[rowIndex].column})');
                  }),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        }
      ),
    );
  }
}
