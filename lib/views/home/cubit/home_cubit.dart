
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test_task/models/data_for_processing_model.dart';
import 'package:webspark_test_task/utils/api.dart';
import 'package:webspark_test_task/utils/failure.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  final Api _api = Api();

  String? endpoint;

  Future<void> getDataForProcessing() async {

    Response? response;

    if (endpoint != null) {

      emit(HomeState(isLoading: true));

      try {
        response = await _api.getDataForProcessing(endpoint!);
      } catch (e) {
        late Failure failure;
        if (e is Failure) {
          failure = e;
        } else {
          failure = Failure(e.toString(), code: 0);
        }
        emit(HomeState(failure: failure));
      }
      
      if (response?.statusCode == 200 && response?.data != null) {
        try {
          final DataForProcessingModel dataForProcessingModel = dataForProcessingModelFromJson(response!.data);
          debugPrint('${dataForProcessingModel.error}');
          debugPrint('${response.statusCode}');
          debugPrint('${response.statusCode.runtimeType}');
          if (dataForProcessingModel.error == false && dataForProcessingModel.message == 'OK' && dataForProcessingModel.data?.isNotEmpty == true) {
            emit(HomeState(data: dataForProcessingModel.data));
            return;
          }
        } catch (e) {
          debugPrint('Error $e');
          debugPrint('${response?.data.runtimeType}');
          emit(HomeState(failure: Failure('Failed to process data, check the link is correct', code: 0)));
          return;
        }
      } else if (response?.statusCode == 200) {
        debugPrint('${response?.data.runtimeType}');
      }
      emit(state.copyWith(isLoading: false));
    }
  }

  void setEndpoint(String text) {
    endpoint = text;
    _api.postUrl = text;
  }
}
