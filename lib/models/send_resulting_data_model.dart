
class SendResultingDataModel {
    String? id;
    Result? result;

    SendResultingDataModel({
        this.id,
        this.result,
    });

    factory SendResultingDataModel.fromJson(Map<String, dynamic> json) => SendResultingDataModel(
        id: json["id"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "result": result?.toJson(),
    };
}

class Result {
    List<Step>? steps;
    String? path;

    Result({
        this.steps,
        this.path,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        steps: json["steps"] == null ? [] : List<Step>.from(json["steps"]!.map((x) => Step.fromJson(x))),
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x.toJson())),
        "path": path,
    };
}

class Step {
    String? x;
    String? y;

    Step({
        this.x,
        this.y,
    });

    factory Step.fromJson(Map<String, dynamic> json) => Step(
        x: json["x"],
        y: json["y"],
    );

    Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
    };
}
