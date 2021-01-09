
import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'dart:math';
import 'models/transaction.dart';
import 'package:flutter/material.dart';


main() => runApp(ExpensesApp());


class ExpensesApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
          ),
        )
      ),
    );

  }

}

class MyHomePage extends StatefulWidget {
  
  
  


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _transactions = [
    Transaction(
      id:'t1',
      title: "Novo Tenis de Corrida",
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3))
    ),
    Transaction(
      id:'t2',
      title: "Conta de luz",
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 4))
    ),
  ];


  List<Transaction> get _recentTransactions {

    return _transactions.where((tr) => tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();

  }

  _addTransaction(String title, double value){ //função para adcionar um novo registro na lista
    
    //Monta a lista
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );


    //Altera o estado da lista no componente 
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context){

    showModalBottomSheet(
      context: context,
      builder: (ctx){
        return TransactionForm(_addTransaction);
      }
    );

  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Despesas Pessoais",
          style: TextStyle(
            fontFamily: 'OpenSans',
          ),
          ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: ()=>_openTransactionFormModal(context),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransctionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>_openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

  }
}