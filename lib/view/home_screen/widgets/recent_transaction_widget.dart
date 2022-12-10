import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_buddy/view/all_transactions/all_transactions.dart';

class RecentTransactionWidget extends StatelessWidget {
  const RecentTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Recent Transaction', style: TextStyle(fontSize: 20)),
      trailing: TextButton(
        onPressed: () => Get.to(const AllTransactions()),
        child: const Text(
          'View All',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
