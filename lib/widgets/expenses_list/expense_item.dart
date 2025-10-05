import 'package:flutter/material.dart';

import 'package:hambaexpense/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 124, 93, 177),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text(expense.title, style: TextStyle(color: Colors.white70)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${expense.amount.toStringAsFixed(2)}",
                  style: TextStyle(color: Colors.white70),
                ),
                Row(
                  children: [
                    Icon(
                      categoryIcons[expense.category],
                      color: Colors.white70,
                    ),
                    SizedBox(width: 6),
                    Text(
                      expense.formattedDate,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
