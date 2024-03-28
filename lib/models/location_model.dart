import 'package:webspark_test_task/models/path_element_model.dart';

class LocationModel {
  final String id;
  final List<List<PathElementModel>> grid;
  final int startRow;
  final int startColumn;
  final int goalRow;
  final int goalColumn;
  LocationModel({
    required this.grid,
    required this.startRow,
    required this.startColumn,
    required this.goalRow,
    required this.goalColumn,
    required this.id,
  });
}