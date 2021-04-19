import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutterdatabase/providers/transaction_provider.dart';
import 'package:flutterdatabase/screens/form_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'models/Transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Local Database'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      Provider.of<TransactionProvider>(context,listen: false).initData();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FormScreen();
                  }));
                })
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, Widget child) {
            var count = provider.transactions.length;
            if (count <= 0) {
              return Center(
                child: Text("Not found", style: TextStyle(fontSize: 35),),
              );
            }else {
              return ListView.builder(
                itemCount: count,
                itemBuilder: (context, int index) {
                  Transactions data = provider.transactions[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 35),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Text(data.name),
                        ),
                      ),
                      title: Text(data.name),
                      subtitle: Column(
                        children: <Widget>[
                            Text("Name: ${data.name}"),
                            Text("Address: ${data.address}"),
                            Text("Phone Number: ${data.phone}"),
                            Text("Username: ${data.username}"),
                            Text("Password: ${data.password}"),
                        ],)
                    ),
                  );
                });
            }
          },
        ));
  }
}
