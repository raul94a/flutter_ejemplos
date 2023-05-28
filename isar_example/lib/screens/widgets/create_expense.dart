// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar_example/models/expense.dart';
import 'package:isar_example/screens/expenses_screen_controller.dart';
import 'package:isar_example/styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateExpense extends StatefulWidget {
  const CreateExpense({
    super.key,
  });

  @override
  State<CreateExpense> createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense>
    with TickerProviderStateMixin {
  final qtyController = TextEditingController(),
      dateController = TextEditingController(),
      descriptionController = TextEditingController();
  late DateTime pickedDate;
  late final AnimationController animationController =
      AnimationController(vsync: this);
  @override
  void initState() {
    final today = DateTime.now();
    pickedDate = today;
    final formattedDate = DateFormat('dd/MM/yyyy').format(today);
    dateController.text = formattedDate;

    super.initState();
  }

  @override
  void dispose() {
    qtyController.dispose();
    dateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: mainBlueColor,
      body: SafeArea(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'title',
                  child: SvgPicture.asset(
                    'assets/coins_1.svg',
                    alignment: Alignment.center,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                BottomSheet(
                    animationController: animationController,
                    onClosing: () {},
                    constraints: BoxConstraints(maxHeight: size.height * 0.6),
                    builder: (ctx) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Create a Expense',
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('Quantity', style: titleStyle),
                            TextFormField(
                              decoration: decoration,
                              controller: qtyController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true, signed: false),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('Date', style: titleStyle),
                            TextFormField(
                              decoration: decoration,
                              controller: dateController,
                              readOnly: true,
                              onTap: () async {
                                final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.parse('2000-01-01'),
                                    lastDate: DateTime.now());
                                if (date != null) {
                                  pickedDate = date;
                                  final formattedDate =
                                      DateFormat('dd/MM/yyyy').format(date);
                                  dateController.text = formattedDate;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('Description', style: titleStyle),
                            TextFormField(
                              decoration: decoration,
                              textInputAction: TextInputAction.done,
                              controller: descriptionController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) => Color.fromARGB(
                                                    255, 190, 79, 71)),
                                        fixedSize:
                                            MaterialStateProperty.resolveWith(
                                                (states) => Size(150, 35))),
                                    onPressed: Navigator.of(context).pop,
                                    child: const Text(
                                      'Exit',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) => mainBlueColor)),
                                    onPressed: () {
                                      //watch out! double.parse(qtyController.text)
                                      //can be null
                                      final provider = context
                                          .read<ExpensesScreenProvider>();
                                      final expense = Expense()
                                        ..description =
                                            descriptionController.text
                                        ..quantity =
                                            double.parse(qtyController.text)
                                        ..date = pickedDate;
                                      provider.createExpense(expense);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Create expense',
                                        style: TextStyle(color: Colors.white))),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const decoration = InputDecoration(
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(),
    filled: true);
