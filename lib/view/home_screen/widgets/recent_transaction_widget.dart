import 'package:flutter/material.dart';

import '../../all_transactions/all_transactions.dart';

class RecentTransactionWidget extends StatelessWidget {
  const RecentTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Recent Transaction', style: TextStyle(fontSize: 20)),
      trailing: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AllTransactions(),
            ),
          );
        },
        child: const Text(
          'View All',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
