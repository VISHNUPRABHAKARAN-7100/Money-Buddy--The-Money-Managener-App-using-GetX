// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields, depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../db/transactions/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transactions/transaction_model.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({super.key});

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  int dropdownButtonValue1 = 1;
  int dropdownButtonValue2 = 1;

  TextEditingController _searchController = TextEditingController();

  List<TransactionModel> newTransactionList =
      TransactionDB.instance.transactionListNotifier.value;

  List<TransactionModel> _valueFounded = [];
  @override
  void initState() {
    _valueFounded = newTransactionList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('All Transactions'),
        backgroundColor: const Color.fromARGB(255, 45, 77, 153),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
// Drop down button For filtering
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: dropdownButtonValue1,
                    items: [
                      DropdownMenuItem(
                        value: 1,
                        child: const Text('All'),
                        onTap: () {
                          setState(() {
                            _valueFounded = TransactionDB
                                .instance.transactionListNotifier.value;
                          });
                        },
                      ),
                      DropdownMenuItem(
                        value: 2,
                        onTap: () {
                          setState(() {
                            _valueFounded = TransactionDB
                                .instance.newIncomeTransactionNotaifier.value;
                          });
                        },
                        child: const Text('Income'),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: const Text('Expense'),
                        onTap: () {
                          setState(() {
                            _valueFounded = TransactionDB
                                .instance.newExpeneseTransactionNotifier.value;
                          });
                        },
                      ),
                    ],
                    onChanged: (value) {
                      setState(
                        () {
                          dropdownButtonValue1 = value!;
                        },
                      );
                    },
                  ),
                ),
              ),
              trailing: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: dropdownButtonValue2,
                    items: [
                      DropdownMenuItem(
                        value: 1,
                        child: const Text('All'),
                        onTap: () {
                          setState(() {
                            _valueFounded = TransactionDB
                                .instance.transactionListNotifier.value;
                          });
                        },
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: const Text('Today'),
                        onTap: () {
                          setState(() {
                            _valueFounded =
                                TransactionDB.instance.todayNotifier.value;
                          });
                        },
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: const Text('Monthly'),
                        onTap: () {
                          setState(() {
                            _valueFounded =
                                TransactionDB.instance.monthlyNotifier.value;
                          });
                        },
                      ),
                      DropdownMenuItem(
                        value: 4,
                        child: const Text('Yearly'),
                        onTap: () {
                          setState(() {
                            _valueFounded =
                                TransactionDB.instance.yearlyNotifier.value;
                          });
                        },
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        dropdownButtonValue2 = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // FormField For Search
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
              ),
              child: TextFormField(
                controller: _searchController,
                onChanged: (value) =>
                    _searchTransaction(_searchController.text),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  hintText: 'Search',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
// List Tile For All Transactions
            (_valueFounded.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _valueFounded.length,
                      itemBuilder: (context, index) {
                        final _value = _valueFounded[index];
                        return Slidable(
                          startActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor:
                                    const Color.fromARGB(255, 234, 81, 70),
                                icon: Icons.delete,
                                onPressed: (context) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        title: const Text('Are you sure?'),
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    TransactionDB.instance
                                                        .deleteTransaction(
                                                            _value.id!);
                                                    TransactionDB.instance
                                                        .refresh();
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                                child: const Text('Ok'),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          key: Key(_value.id!),
                          child: Card(
                            elevation: 3,
                            child: ListTile(
                              title: Text(
                                _value.category.name,
                              ),
                              subtitle: Text(
                                parsedDate(_value.date),
                              ),
                              trailing: _value.type == CategoryType.Expenses
                                  ? Text(
                                      '₹${_value.amount}',
                                      style: const TextStyle(color: Colors.red),
                                    )
                                  : Text(
                                      '₹${_value.amount}',
                                      style:
                                          const TextStyle(color: Colors.green),
                                    ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      title: Text(_value.type.name),
                                      children: [
                                        SimpleDialogOption(
                                          child: Text(
                                            'Date:- ${parsedDate(_value.date)}',
                                          ),
                                        ),
                                        SimpleDialogOption(
                                          child: Text(
                                            'Category:-${_value.category.name}',
                                          ),
                                        ),
                                        SimpleDialogOption(
                                          child: Text(
                                            'Amount:- ${_value.amount}',
                                          ),
                                        ),
                                        SimpleDialogOption(
                                          child: Text(
                                            'Note:- ${_value.note}',
                                          ),
                                        ),
                                        SimpleDialogOption(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Ok'),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Image.asset('assets\\no_transaction_found.png'),
                  )),
          ],
        ),
      ),
    );
  }

  parsedDate(data) {
    final formatedDate = DateFormat.yMMMd().format(data);
    final splitedDate = formatedDate.split(' ');
    return '${splitedDate[1]} ${splitedDate.first} ${splitedDate.last} ';
  }

// Function for search a transaction in all transaction
  void _searchTransaction(String enteredValue) {
    List<TransactionModel> results = [];
    if (enteredValue.isEmpty) {
      results = newTransactionList;
    } else {
      results = newTransactionList
          .where((element) => element.category.name
              .trim()
              .toLowerCase()
              .contains(enteredValue.trim().toLowerCase()))
          .toList();
    }
    setState(() {
      _valueFounded = results;
    });
  }
}
