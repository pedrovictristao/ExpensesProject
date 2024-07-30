import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: const MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: const Color.fromARGB(255, 142, 2, 177),
          secondary: const Color.fromARGB(255, 142, 2, 177),
        ),
        textTheme: tema.textTheme.copyWith(
            titleLarge: const TextStyle(
              fontFamily: 'Merriweather',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            bodyLarge: const TextStyle(
              fontFamily: 'Merriweather',
              color: Colors.white,
            ),
            bodySmall: const TextStyle(
              fontFamily: 'Merriweather',
              color: Color.fromARGB(255, 100, 100, 100),
            ),
            labelSmall: const TextStyle(
              fontFamily: 'Merriweather',
              fontSize: 12,
              color: Colors.black,
            )),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Color.fromARGB(255, 142, 2, 177),
          centerTitle: true,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String titleTransaction, double valueTransaction,
      DateTime dateTransaction) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: titleTransaction,
      value: valueTransaction,
      date: dateTransaction,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas pessoais'),
        // actions: [
        //   IconButton(
        //     onPressed: () => _openTransactionFormModal(context),
        //     icon: const Icon(Icons.add),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(recentTransactions: _recentTransactions),
            TransactionList(_transactions, _removeTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
