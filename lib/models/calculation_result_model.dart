
import 'package:webspark_test_task/models/location_model.dart';
import 'package:webspark_test_task/models/path_element_model.dart';

class CalculationResultModel {
  final List<PathElementModel> calculatedPath;
  final LocationModel locationModel;
  CalculationResultModel({
    required this.calculatedPath,
    required this.locationModel,
  });
}
