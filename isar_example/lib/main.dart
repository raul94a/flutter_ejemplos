import 'package:flutter/material.dart';
import 'package:isar_example/database/isar_helper.dart';
import 'package:isar_example/database/expense_dao.dart';
import 'package:isar_example/screens/expenses_screen.dart';
import 'package:isar_example/screens/expenses_screen_controller.dart';
import 'package:isar_example/styles/colors.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarHelper.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpensesScreenProvider(expensesDao: ExpenseDao()),
      child: MaterialApp(
        theme: theme,
        home: const ExpensesScreen(),
      ),
    );
  }
}

var theme = ThemeData.light(
  useMaterial3: true,
).copyWith(
    primaryColor: mainBlueColor,
    colorScheme: const ColorScheme.light(
        primary: mainBlueColor, secondary: Colors.deepOrangeAccent),
    appBarTheme: const AppBarTheme(
        backgroundColor: mainBlueColor,
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 23.0)));
