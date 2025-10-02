import "package:flutter/material.dart";
import "package:hambaexpense/models/expense.dart";

import "package:hambaexpense/widgets/expenses_list/expenses_list.dart";
import 'package:hambaexpense/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => ExpensesState();
}

class ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  void _undoRemoveExpense(Expense expense, int index) {
    setState(() {
      _registeredExpenses.insert(index, expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    void openAddExpenseOverlay() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(onAddExpense: _addExpense);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Hamba Expense Tracker"),
        actions: [
          IconButton(onPressed: openAddExpenseOverlay, icon: Icon(Icons.add)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("The Chart"),
            Expanded(
              child: ExpensesList(
                expenses: _registeredExpenses,
                onRemoveExpense: _removeExpense,
                onUndoRemoveExpense: _undoRemoveExpense,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
