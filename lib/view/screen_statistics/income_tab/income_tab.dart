import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../db/transactions/transaction_db.dart';
import '../../../models/transactions/transaction_model.dart';

class IncomeTab extends StatefulWidget {
  const IncomeTab({super.key});

  @override
  State<IncomeTab> createState() => _IncomeTabState();
}

class _IncomeTabState extends State<IncomeTab> {
  late List<TransactionModel> _chartData;
  @override
  void initState() {
    _chartData = TransactionDB.instance.newIncomeTransactionNotaifier.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.newIncomeTransactionNotaifier,
      builder: (BuildContext context, List<TransactionModel> value, _) {
        return SfCircularChart(
          legend: Legend(
            isVisible: true,
            position: LegendPosition.right,
            backgroundColor: Colors.black12,
          ),
          series: <CircularSeries>[
            PieSeries<TransactionModel, String>(
              explode: true,
              dataSource: _chartData,
              xValueMapper: (TransactionModel data, _) {
                return data.category.name;
              },
              yValueMapper: (TransactionModel data, _) => data.amount,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ),
            ),
          ],
        );
      },
    );
  }
}
