import "package:flutter/material.dart";
import "package:intl/intl.dart";

import 'package:hambaexpense/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => NewExpenseState();
}

class NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? valueOfDate;
  Category selectedCategory = Category.food;

  void _saveExpense() {
    final enteredTitle = titleController.text.trim();
    final enteredAmount = double.tryParse(amountController.text);
    final isEnteredAmountInvalid = enteredAmount == null || enteredAmount <= 0;

    if (enteredTitle.isEmpty ||
        enteredTitle.length < 3 ||
        isEnteredAmountInvalid ||
        valueOfDate == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Invalid Input"),
            content: Text(
              "Please make sure a valid title, amount, date and category was entered.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Okay"),
              ),
            ],
          );
        },
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: enteredTitle,
        amount: enteredAmount,
        date: valueOfDate!,
        category: selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void openDatePicker() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );

    setState(() {
      valueOfDate = selectedDate ?? DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text("Title")),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text("Amount"),
              prefixText: "\$",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                value: selectedCategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              Row(
                children: [
                  Text(
                    (valueOfDate == null)
                        ? "No Date Chosen"
                        : DateFormat.yMd().format(valueOfDate!),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.calendar_month),
                    onPressed: openDatePicker,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _saveExpense,
                child: Text("Save Expense"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
