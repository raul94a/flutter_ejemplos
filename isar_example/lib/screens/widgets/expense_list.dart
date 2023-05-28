// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar_example/models/expense.dart';
import 'package:isar_example/screens/expenses_screen_controller.dart';
import 'package:isar_example/styles/colors.dart';
import 'package:provider/provider.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final expenses = context.watch<ExpensesScreenProvider>().expenses;
    if (expenses.isEmpty) {
      return const Center(
        heightFactor: 3,
        child: Text('No expenses to show!'),
      );
    }
    return Column(
      children: [
        const _Headers(),
        _Divider(),
        Expanded(
          child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (ctx, index) {
                final expense = expenses[index];
                final formatedDate =
                    DateFormat('dd/MM/yyyy').format(expense.date);
                return Material(
                  color: index % 2 == 1 ? cardColor : null,
                  child:
                      _ExpenseRow(expense: expense, formatedDate: formatedDate),
                );
              }),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(top: 0, bottom: 0),
      child: const Divider(),
    );
  }
}

class _Headers extends StatelessWidget {
  const _Headers();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .labelLarge
        ?.copyWith(fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(
                'Quantity',
                style: textTheme,
                textAlign: TextAlign.right,
              )),
          const SizedBox(
            width: 20,
          ),
          Expanded(flex: 6, child: Text('Description', style: textTheme)),
          Expanded(
            flex: 4,
            child: Text('Date', style: textTheme),
          ),
        ],
      ),
    );
  }
}

class _ExpenseRow extends StatelessWidget {
  const _ExpenseRow({required this.expense, required this.formatedDate});

  final Expense expense;
  final String formatedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0).copyWith(right: 0.0, left: 0.0),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(
                '${expense.quantity.toStringAsFixed(2)} €',
                textAlign: TextAlign.right,
              )),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              flex: 6,
              child: Text(expense.description,
                  maxLines: 2, style: TextStyle(color: Colors.black))),
          Expanded(
              flex: 4,
              child: Row(
                children: [
                  Text(formatedDate),
                  GestureDetector(
                    onTap: () {
                      context.read<ExpensesScreenProvider>().delete(expense);
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
