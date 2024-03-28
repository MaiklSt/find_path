import 'package:flutter/material.dart';
import 'package:webspark_test_task/configs/app_strings.dart';
import 'package:webspark_test_task/models/calculation_result_model.dart';
import 'package:webspark_test_task/models/path_element_model.dart';
import 'package:webspark_test_task/views/widgets/custom_appbar.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen(this.listCalculationResultModel, {super.key});

  final CalculationResultModel listCalculationResultModel;

  @override
  Widget build(BuildContext context) {
    final matrixSize = listCalculationResultModel.locationModel.grid.length;
    return Scaffold(
      appBar: const CustomAppBar(title: Text(AppStrings.previewScreen)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: matrixSize,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
          ),
          itemCount: matrixSize * matrixSize,
          itemBuilder: (context, index) {
            final row = index ~/ matrixSize;
            final column = index % matrixSize;
            final PathElementModel pathElementModel =
                listCalculationResultModel.locationModel.grid[row][column];

            final Color color = pathElementModel.row ==
                        listCalculationResultModel.locationModel.startRow &&
                    pathElementModel.column ==
                        listCalculationResultModel.locationModel.startColumn
                ? const Color(0xFF64FFDA)//starting field
                : row == listCalculationResultModel.locationModel.goalRow &&
                        column ==
                            listCalculationResultModel.locationModel.goalColumn
                    ? const Color(0xFF009688)//finishing field
                    : listCalculationResultModel
                            .locationModel.grid[row][column].inPath
                        ? const Color(0xFF4CAF50)//shortest path field
                        : !listCalculationResultModel
                                .locationModel.grid[row][column].passable
                            ? const Color(0x00000000)//locked field, color transparent
                            : const Color(0x00ffffff);//free field, transparent color

            return Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.black),
                ),
                alignment: Alignment.center,
                child:
                    Text('${pathElementModel.column},${pathElementModel.row}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
