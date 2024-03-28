class PathElementModel {

  PathElementModel({this.row, this.column});

  double g = 0;
  double h = 0;

  int? row;
  int? column;

  bool passable = true;
  bool visited = false;
  bool inPath = false;

  PathElementModel? parent;
}