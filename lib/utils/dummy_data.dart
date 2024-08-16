import 'dart:convert';
import 'package:expense_tracker_app/model/expense_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DummyData {
  late SharedPreferences prefs;

  saveData({required int amount, required String category, required String date}) async {
    try {
      prefs = await SharedPreferences.getInstance();

      List<Result> mainResult = [];

       ExpModel? expModel3 = await getData();
       mainResult = expModel3?.result ?? [];


      Result result = Result(amount: amount, category: category, date: date);
      mainResult.add(result);

      List<String>? mainResultData = [];
      for (var element in mainResult) {
        final String data = jsonEncode(element.toJson()); // element.toJson().toString();
        mainResultData.add(data);
      }
      prefs.setStringList("ExpData", mainResultData);
    } catch (e, d) {
      print("Data error: $e");
      print("Data Stack: $d");
    }
  }

  Future<ExpModel?> getData() async {
    try {
      prefs = await SharedPreferences.getInstance();
      List<String> data = prefs.getStringList("ExpData") ?? [];
      if (data.isEmpty) return null;

      List<Result>? mainResult = [];

      for (var element in data) {
        Map<String, dynamic> mapData = jsonDecode(element);

        Result result = Result(amount: mapData["amount"], category: mapData["category"], date: mapData["Date"]);
        mainResult.add(result);
      }
      final ExpModel expModel = ExpModel(result: mainResult);

      return expModel;
    } catch (e, d) {
      print("Get Data error: $e");
      print("Get Data Stack: $d");
      return null;
    }
  }
}

