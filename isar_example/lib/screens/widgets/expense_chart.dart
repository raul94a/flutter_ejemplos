import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar_example/screens/expenses_screen_controller.dart';
import 'package:isar_example/styles/colors.dart';
import 'package:provider/provider.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({super.key});

  String getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 0:
        return 'Sun';
      default:
        return 'Sun';
    }
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = context.watch<ExpensesScreenProvider>();
    final loading = expenseProvider.loading;
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    final orderedExpenses = expenseProvider.groupWeekExpensesByDay();
    //from Monday to Sunday
    final dates = orderedExpenses.keys.toList().reversed.toList();
    //total expenses of the week. It is set in the method groupWeekExpensesByDay()
    num total = expenseProvider.total;

    return Card(
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Week expenses',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(dates.length, growable: false, (index) {
                //get the list of expenses and accumulate the quantity (sum)
                final date = dates[index];
                final totalDay =
                    orderedExpenses[date]!.fold(0.0, (a, b) => a + b.quantity);
                double fraction = 0.0;
                if (total > 0) {
                  //get the fraction respecting the total amount (quantity expended the present week)
                  fraction = totalDay / total;
                }

                DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);

                final dayOfWeek = getDayOfWeek(parsedDate.weekday);
                debugPrint('Week day: $dayOfWeek');
                debugPrint('Fraction $fraction');
                return _ChartBar(fraction: fraction, dayOfWeek: dayOfWeek);
              }),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartBar extends StatelessWidget {
  const _ChartBar({
    required this.fraction,
    required this.dayOfWeek,
  });

  final double fraction;
  final String dayOfWeek;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          Container(
            width: 15,
            height: 150,
            decoration: BoxDecoration(
                border: Border.all(color: borderBarColor, width: 1.8),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0)),
            child: FractionallySizedBox(
              alignment: Alignment.bottomCenter,
              heightFactor: fraction,
              child: Container(
                decoration: const BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(4.0),
                        bottomRight: Radius.circular(4.0),
                        topRight: Radius.circular(5.0))),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(dayOfWeek)
        ],
      ),
    );
  }
}
