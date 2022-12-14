import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_buddy/core/constants.dart';
import '../../db/category/category_db.dart';
import '../../models/category/category_model.dart';

class ScreenCategories extends StatefulWidget {
  const ScreenCategories({super.key});

  @override
  State<ScreenCategories> createState() => _ScreenCategoriesState();
}

class _ScreenCategoriesState extends State<ScreenCategories>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
// Tabs In Categories
        TabBar(
          labelColor: Colors.black,
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Income',
            ),
            Tab(
              text: 'Expense',
            ),
          ],
        ),
// Grid View For Income Category
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              ValueListenableBuilder(
                valueListenable: CategoryDB().incomeCategoaryListLisner,
                builder: (context, List<CategoryModel> newlist, _) {
                  return GridView.builder(
                    itemCount: newlist.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      final categorynew = newlist[index];
                      return Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(categorynew.name),
                            IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  barrierDismissible: false,
                                  content: const Text(''),
                                  title: 'Are you sure?',
                                  titleStyle: textStyleForViewTransaction,
                                  cancel: TextButton(
                                    onPressed: (() => Get.back()),
                                    child: const Text(
                                      'Cancel',
                                      style: textStyleForViewTransaction,
                                    ),
                                  ),
                                  confirm: TextButton(
                                    onPressed: () {
                                      CategoryDB.instance
                                          .deletecategory(categorynew.id);
                                      Get.back();
                                    },
                                    child: const Text(
                                      'Yes, Delete It',
                                      style: textStyleForViewTransaction,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
// Grid View For Expense Category

              ValueListenableBuilder(
                valueListenable: CategoryDB().expensesCategoaryListLisner,
                builder: (context, List<CategoryModel> newlist, _) {
                  return GridView.builder(
                    itemCount: newlist.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      final categorynew = newlist[index];
                      return Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(categorynew.name),
                            IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  barrierDismissible: false,
                                  content: const Text(''),
                                  title: 'Are you sure?',
                                  titleStyle: textStyleForViewTransaction,
                                  cancel: TextButton(
                                    onPressed: (() => Get.back()),
                                    child: const Text(
                                      'Cancel',
                                      style: textStyleForViewTransaction,
                                    ),
                                  ),
                                  confirm: TextButton(
                                    onPressed: () {
                                      CategoryDB.instance
                                          .deletecategory(categorynew.id);
                                      Get.back();
                                    },
                                    child: const Text(
                                      'Yes, Delete It',
                                      style: textStyleForViewTransaction,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
