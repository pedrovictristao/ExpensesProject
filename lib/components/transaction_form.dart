import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm({super.key});

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: valueController,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => {
                    print(titleController.text),
                    print(valueController.text),
                  },
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(
                        const Color.fromARGB(255, 145, 10, 0)),
                  ),
                  child: const Text('Nova transação'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
