
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test_task/models/calculation_result_model.dart';
import 'package:webspark_test_task/models/data_for_processing_model.dart';
import 'package:webspark_test_task/models/location_model.dart';
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

  Future<void> sendResultsToServer() async {}
}
