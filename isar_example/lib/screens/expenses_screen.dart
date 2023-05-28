import 'package:flutter/material.dart';
import 'package:isar_example/screens/widgets/create_expense.dart';
import 'package:isar_example/screens/widgets/expense_chart.dart';
import 'package:isar_example/screens/widgets/expense_list.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses screen')),
      floatingActionButton: FloatingActionButton(
        heroTag: 'title',
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const CreateExpense()));
        },
        child: const Icon(Icons.add),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpenseChart(),
          _ExpenseList(),
        ],
      ),
    );
  }
}

class _ExpenseList extends StatelessWidget {
  const _ExpenseList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Expenses',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            //List
            const Expanded(child: ExpenseList())
          ],
        ),
      ),
    );
  }
}
