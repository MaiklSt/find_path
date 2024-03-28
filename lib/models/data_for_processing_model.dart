
DataForProcessingModel dataForProcessingModelFromJson(Map<String, dynamic> map) => DataForProcessingModel.fromJson(map);

class DataForProcessingModel {
    bool? error;
    String? message;
    List<Data>? data;

    DataForProcessingModel({
        this.error,
        this.message,
        this.data,
    });

    factory DataForProcessingModel.fromJson(Map<String, dynamic> json) => DataForProcessingModel(
        error: json['error'],
        message: json['message'],
        data: json['data'] == null ? [] : List<Data>.from(json['data']!.map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'data': data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Data {
    String? id;
    List<String>? field;
    Position? start;
    Position? end;

    Data({
        this.id,
        this.field,
        this.start,
        this.end,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        field: json['field'] == null ? [] : List<String>.from(json['field']!.map((x) => x)),
        start: json['start'] == null ? null : Position.fromJson(json['start']),
        end: json['end'] == null ? null : Position.fromJson(json['end']),
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'field': field == null ? [] : List<dynamic>.from(field!.map((x) => x)),
        'start': start?.toJson(),
        'end': end?.toJson(),
    };
}

class Position {
    int? x;
    int? y;

    Position({
        this.x,
        this.y,
    });

    factory Position.fromJson(Map<String, dynamic> json) => Position(
        x: json['x'],
        y: json['y'],
    );

    Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
    };
}
