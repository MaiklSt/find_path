
import 'dart:async';

import 'package:webspark_test_task/models/calculation_result_model.dart';
import 'package:webspark_test_task/models/data_for_processing_model.dart';
import 'package:webspark_test_task/models/location_model.dart';
import 'package:webspark_test_task/models/path_element_model.dart';

class HelperClass {

  int _rowSize = 0;
  int _columnSize = 0;

  LocationModel initialLocation(Data data) {

    //set the matrix size
    _rowSize = data.field?[0].length ?? 0;
    _columnSize = data.field?.length ?? 0;

    //create an empty matrix
    final List<List<PathElementModel>> grid = <List<PathElementModel>>[<PathElementModel>[]];
    for (int row = 0; row < _rowSize; row++) {

      if (row < _rowSize - 1) {
        grid.add(<PathElementModel>[]);
      }

      for (int column = 0; column < _columnSize; column++) {
        grid[row].add(PathElementModel(row: row, column: column)..passable = data.field?[row][column] == '.');
      }
    }

    return LocationModel(
      id: data.id ?? '',
      grid: grid,
      startRow: data.end?.x ?? 0,
      startColumn: data.end?.y ?? 0,
      goalRow: data.start?.x ?? 0,
      goalColumn: data.start?.y ?? 0,
    );
  }

  Future<CalculationResultModel> runFinder(LocationModel locationModel, {bool isBFS = false, Function? update}) async {

    final List<PathElementModel> queue = <PathElementModel>[locationModel.grid[locationModel.startRow][locationModel.startColumn]..visited = true];

    int? currentRow;
    int? currentColumn;

    PathElementModel currentPathElement = queue.removeAt(0);

    currentPathElement
      ..g = 0
      ..h = calculateHeuristic(
        row: currentPathElement.row!,
        column: currentPathElement.column!,
        isBFS: isBFS,
        locationModel: locationModel,
      );

    currentRow = currentPathElement.row;
    currentColumn = currentPathElement.column;

    while (locationModel.grid[locationModel.goalRow][locationModel.goalColumn] != currentPathElement) {

      await Future<void>.delayed(const Duration(milliseconds: 10), () {
        _addChild(
          row: currentRow! - 1,
          column: currentColumn! - 1,
          queue: queue,
          element: currentPathElement,
          isBFS: isBFS,
          locationModel: locationModel,
        );

        _addChild(
          row: currentRow! - 1,
          column: currentColumn!,
          queue: queue,
          element: currentPathElement,
          isBFS: isBFS,
          locationModel: locationModel,
        );

        _addChild(
          row: currentRow! - 1,
          column: currentColumn! + 1,
          queue: queue,
          element: currentPathElement,
          isBFS: isBFS,
          locationModel: locationModel,
        );

        _addChild(
          row: currentRow!,
          column: currentColumn! - 1,
          queue: queue,
          element: currentPathElement,
          isBFS: isBFS,
          locationModel: locationModel,
        );

        _addChild(
          row: currentRow!,
          column: currentColumn! + 1,
          queue: queue,
          element: currentPathElement,
          isBFS: isBFS,
          locationModel: locationModel,
        );
        _addChild(
          row: currentRow! + 1,
          column: currentColumn! - 1,
          queue: queue,
          element: currentPathElement,
          isBFS: isBFS,
          locationModel: locationModel,
        );

        _addChild(
          row: currentRow! + 1,
          column: currentColumn!,
          queue: queue,
          element: currentPathElement,
          isBFS: isBFS,
          locationModel: locationModel,
        );

        _addChild(
          row: currentRow! + 1,
          column: currentColumn! + 1,
          queue: queue,
          element: currentPathElement,
          isBFS: isBFS,
          locationModel: locationModel,
        );

        currentPathElement = getBestChild(queue);

        currentRow = currentPathElement.row;
        currentColumn = currentPathElement.column;

      });
    }

    return CalculationResultModel(calculatedPath: _showShortestPath(currentPathElement), locationModel: locationModel);
  }

  void _addChild({
    required int row,
    required int column,
    required List<PathElementModel> queue,
    required PathElementModel element,
    required bool isBFS,
    required LocationModel locationModel,
  }) {
    if (row >= 0 && column >= 0 && row < _rowSize && column < _columnSize) {
      if (!locationModel.grid[row][column].visited && locationModel.grid[row][column].passable) {
        final double h =
            calculateHeuristic(row: row, column: column, isBFS: isBFS, locationModel: locationModel);

        queue.add(
          locationModel.grid[row][column]
            ..visited = true
            ..parent = element
            ..g = element.g
            ..h = h,
        );
      }
    }
  }

  double calculateHeuristic({
    required int row,
    required int column,
    required bool isBFS,
    required LocationModel locationModel,
  }) =>
      isBFS
          ? 0
          : ((row - locationModel.goalRow).abs() + (column - locationModel.goalColumn).abs()).toDouble();


  PathElementModel getBestChild(List<PathElementModel> queue) {
    int minIndex = 0;
    double minValue = double.infinity;

    for (int i = 0; i < queue.length; i++) {
      if (queue[i].g + queue[i].h < minValue) {
        minIndex = i;
        minValue = queue[i].g + queue[i].h;
      }
    }

    return queue.removeAt(minIndex);
  }

  List<PathElementModel> _showShortestPath(PathElementModel goal) {

    final List<PathElementModel> path = [];

    PathElementModel pathElement = goal;

    while (pathElement.parent != null) {
      pathElement.inPath = true;
      path.add(pathElement);
      pathElement = pathElement.parent!;
    }

    path.add(pathElement);

    return path;
  }
}
