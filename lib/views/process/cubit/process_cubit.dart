
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test_task/models/calculation_result_model.dart';
import 'package:webspark_test_task/models/data_for_processing_model.dart';
import 'package:webspark_test_task/models/location_model.dart';
import 'package:webspark_test_task/models/send_resulting_data_model.dart';
import 'package:webspark_test_task/utils/api.dart';
import 'package:webspark_test_task/utils/error_handler.dart';
import 'package:webspark_test_task/utils/failure.dart';
import 'package:webspark_test_task/utils/helper_class.dart';

part 'process_state.dart';

class ProcessCubit extends Cubit<ProcessState> {

  ProcessCubit() : super(ProcessState());

  final HelperClass _helperClass = HelperClass();

  final List<CalculationResultModel> list = [];

  void init(final List<Data> dataList) async {

    for (int i = 0; i < dataList.length + 1; i++) {

      await Future.delayed(const Duration(milliseconds: 1));
      if (i < dataList.length) {
        final LocationModel _locationModel = _helperClass.initialLocation(dataList[i]);
        list.add(await _helperClass.runFinder(_locationModel));        
      }

      final double scaledValue = _scaleValue(i.toDouble(), 0, dataList.length.toDouble());

      emit(state.copyWith(progress: scaledValue));
    }

    emit(state.copyWith(isProcessing: false));
  }

  double _scaleValue(double value, double min, double max) => (value - min) / (max - min);

  Future<bool> sendResultsToServer() async {

    emit(state.copyWith(isSending: true, isFailure: false));

    Response? response;
    bool sendingResult = false;

    final Api _api = Api();
    final List<Map<String, dynamic>> calculationResult = [];

    for (var calculationResultModel in list) {
      final SendResultingDataModel sendResultingDataModel = SendResultingDataModel(
        id: calculationResultModel.locationModel.id,
        result: Result(
          steps: List.generate(calculationResultModel.calculatedPath.length, (index) => Step(x: calculationResultModel.calculatedPath[index].row.toString(), y: calculationResultModel.calculatedPath[index].column.toString())),
          path: calculationResultModel.calculatedPath.map((pathElementModel) => '(${pathElementModel.row},${pathElementModel.column})').join('->'),
        )
      );

      // sendResultingDataModel.result?.steps = []; //breaking data for test
      calculationResult.add(sendResultingDataModel.toJson());
    }

    try {
      response = await _api.sendResultsToServer(calculationResult);
      if (response.statusCode == 200) {
        final DataForProcessingModel dataForProcessingModel = dataForProcessingModelFromJson(response.data);
        if (dataForProcessingModel.error == false && dataForProcessingModel.message == 'OK') {
          sendingResult = true;
        }
      }
    } catch (e) {
      emit(state.copyWith(isSending: false, isFailure: true, failure: ErrorHandler.handleError(e)));
      return false;
    }

    emit(state.copyWith(isSending: false));

    return sendingResult;
  }
}
