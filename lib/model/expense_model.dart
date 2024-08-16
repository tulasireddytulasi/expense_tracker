import 'dart:convert';

ExpModel expModelFromJson(String str) => ExpModel.fromJson(json.decode(str));

String expModelToJson(ExpModel data) => json.encode(data.toJson());

class ExpModel {
  List<Result>? result;

  ExpModel({
    this.result,
  });

  factory ExpModel.fromJson(Map<String, dynamic> json) => ExpModel(
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? amount;
  String? category;
  String? date;

  Result({
    this.amount,
    this.category,
    this.date,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    amount: json["amount"],
    category: json["category"],
    date: json["Date"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "category": category,
    "Date": date,
  };
}
