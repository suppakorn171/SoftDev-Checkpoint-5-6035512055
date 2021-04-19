import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutterdatabase/database/transaction_db.dart';
import 'package:flutterdatabase/models/Transactions.dart';

class TransactionProvider with ChangeNotifier{
  List<Transactions> transactions = [];

  List<Transactions> getTransaction(){
    return transactions;
  }

  void initData()async{
    var db = TransactionDB(dbName: "transactions.db");
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void addTransaction(Transactions statement)async{
    var db = TransactionDB(dbName: "transactions.db");
    await db.InsertData(statement);
    transactions = await db.loadAllData();
    notifyListeners();
  }

}