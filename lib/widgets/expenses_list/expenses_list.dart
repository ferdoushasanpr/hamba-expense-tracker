import "package:flutter/material.dart";
import 'package:hambaexpense/models/expense.dart';

import 'package:hambaexpense/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
    required this.onUndoRemoveExpense,
  });

  final List<Expense> expenses;
  final Function(Expense expense) onRemoveExpense;
  final Function(Expense expense, int index) onUndoRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        Expense expense = expenses[index];
        int expenseIndex = index;
        return Dismissible(
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 3),
                content: Text("Successfully Deleted The Expense."),
                action: SnackBarAction(
                  label: "Undo",
                  onPressed: () {
                    onUndoRemoveExpense(expense, expenseIndex);
                  },
                ),
              ),
            );
          },
          key: ValueKey(expenses[index]),
          child: ExpenseItem(expense: expenses[index]),
        );
      },
    );
  }
}
