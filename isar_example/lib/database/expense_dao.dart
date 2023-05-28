import 'package:isar/isar.dart';
import 'package:isar_example/database/isar_helper.dart';
import 'package:isar_example/models/expense.dart';

class ExpenseDao {
  final isar = IsarHelper.instance.isar;

  Future<List<Expense>> getAll() => isar.expenses.where().findAll();

  Future<void> create(Expense expense) async {
    int id = await isar.writeTxn(() => isar.expenses.put(expense));
    expense.id = id;
  }

  Future<bool> delete(Expense expense) {
    return isar.writeTxn(() => isar.expenses.delete(expense.id));
  }

  Future<void> update(Expense expense) {
    return isar.writeTxn(() => isar.expenses.put(expense));
  }
}
