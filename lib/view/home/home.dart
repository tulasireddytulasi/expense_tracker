import 'package:expense_tracker_app/model/expense_model.dart';
import 'package:expense_tracker_app/utils/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  List<Result>? mainResult = [];
  late DummyData dummyData;
  int finalAmount = 0;

  @override
  void initState() {
    super.initState();
    initialize();
  }



  initialize() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
    dummyData = DummyData();
    await dummyData.saveData(amount: 2686, category: "Shopping 555", date: "22-05-2024");
    ExpModel? expModel = await dummyData.getData();
    mainResult = expModel?.result;
    mainResult?.forEach(
      (element) {
        finalAmount = finalAmount + int.parse(element.amount.toString());
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Total Amount: $finalAmount",
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            SingleChildScrollView(
              child: mainResult!.isEmpty
                  ? const Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(fontSize: 28, color: Colors.black),
                  ))
                  : Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TableWidget(mainResult: mainResult ?? []),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          dummyData = DummyData();
          await dummyData.saveData(amount: 1000, category: "Shopping 1", date: "22-05-2024");
          ExpModel? expModel = await dummyData.getData();
          mainResult = expModel?.result;
          finalAmount = 0;
          mainResult?.forEach(
                (element) {
                  finalAmount += int.parse(element.amount.toString());
                },
          );
          setState(() {});
        },
        child: const Text("Add Data", textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: Colors.white),),
      ),
    );
  }
}

class TableWidget extends StatelessWidget {
  const TableWidget({super.key, required this.mainResult});

  final List<Result> mainResult;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(
          label: Text('Amount'),
        ),
        DataColumn(
          label: Text('Category'),
        ),
        DataColumn(
          label: Text('Date'),
        ),
      ],
      rows: List<DataRow>.generate(
        mainResult.length,
        (index) => DataRow(
          cells: [
            DataCell(Text(mainResult[index].amount.toString())),
            DataCell(Text(mainResult[index].category.toString())),
            DataCell(Text(mainResult[index].date.toString())),
          ],
        ),
      ),
    );
  }
}
