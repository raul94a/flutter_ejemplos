// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'expense.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  double quantity = 0.0;
  String description = '';

  @Index(type: IndexType.value)
  DateTime date = DateTime.now();

  @enumerated
  Payment payment = Payment.cash;

  @override
  String toString() {
    return 'Expense(id: $id, quantity: $quantity, description: $description, payment: $payment, date=$date)';
  }
}

enum Payment { card, cash }
