// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:isar_example/models/expense.dart';
import 'package:isar_example/database/expense_dao.dart';

class ExpensesScreenProvider with ChangeNotifier {
  final ExpenseDao expensesDao;
  final _expenses = <Expense>[];
  num _total = 0.0;
  bool _loading = false;

  num get total => _total;
  bool get loading => _loading;
  List<Expense> get expenses =>
      _expenses..sort((a, b) => a.date.isBefore(b.date) ? 1 : 0);

  List<Expense> get weekExpenses {
    final today = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
    //last 7 days...
    final firstDay = today.subtract(const Duration(days: 7));

    return expenses
        .where((element) =>
            element.date.isBefore(today) && element.date.isAfter(firstDay))
        .toList();
  }

  ExpensesScreenProvider({
    required this.expensesDao,
  }) {
    getExpenses();
  }

  Future<void> getExpenses() async {
    try {
      _loading = true;
      notifyListeners();
      final expenses = await expensesDao.getAll();
      _expenses.addAll(expenses);
    } catch (ex) {
      debugPrint('$ex');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> createExpense(Expense expense) async {
    expensesDao.create(expense);
    _expenses.add(expense);
    notifyListeners();
  }

  Future<void> delete(Expense expense) async {
    _expenses.removeWhere((element) => element.id == expense.id);
    notifyListeners();
    expensesDao.delete(expense);
  }

  //after getting the week expenses, we have to group them by day (dd/MM/yyy, ej 20/05/2023)
  //This is done by getting the time difference between today and the last 7 days.
  //Once this is done, a loop will fill the keys of the map with the formatted date dd/MM/yyyy
  //and an empty list of Expense.
  //Then, we make a loop over the weekExpenses to group the expenses to each date, and also to
  //get the total amount expended in the last week. (this will be used to show the fractional columns in the expense chart)
  Map<String, List<Expense>> groupWeekExpensesByDay() {
    final filteredExpenses = weekExpenses;
    final orderedExpenses = <String, List<Expense>>{};

    final today = DateTime.now().copyWith(hour: 0);
    //last 7 days...
    final firstDay = today.subtract(const Duration(days: 7));
    int daysOfDifference = today.difference(firstDay).inDays;
    //first: Fill the keys in the map of the last seven days
    for (int i = 0; i < daysOfDifference; i++) {
      final day = DateTime.now().subtract(Duration(days: i));
      final formatted = DateFormat('dd/MM/yyyy').format(day);
      debugPrint('Formated day: $formatted');
      orderedExpenses.addAll({formatted: []});
    }
    _total = 0.0;
    for (final expense in filteredExpenses) {
      final date = DateFormat('dd/MM/yyyy').format(expense.date);
      _total += expense.quantity;
      orderedExpenses[date]!.add(expense);
    }
    return orderedExpenses;
  }
}
