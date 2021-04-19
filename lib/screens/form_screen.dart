import 'package:flutter/material.dart';
import 'package:flutterdatabase/models/Transactions.dart';
import 'package:flutterdatabase/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  // controller
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Page 2"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: new InputDecoration(labelText: "Name"),
                  autofocus: true,
                  controller: nameController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Address"),
                  controller: addressController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Please Enter Address";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Phone-Number"),
                  controller: phoneController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Please Enter Phune-Number";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "User (E-mail)"),
                  controller: usernameController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Please Enter Email";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Password"),
                  obscureText: true,
                  controller: passwordController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Please Enter Password";
                    }
                    return null;
                  },
                ),
                FlatButton(
                  child: Text("Login"),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      var name = nameController.text;
                      var address = addressController.text;
                      var phone = phoneController.text;
                      var username = usernameController.text;
                      var password = passwordController.text;

                      Transactions statement = Transactions(
                        name: name,
                        address: address,
                        phone: phone,
                        username: username,
                        password: password,
                        date: DateTime.now()
                      );

                      Container(
                        padding: EdgeInsets.all(50.0),
                        child: Text(name),
                );

                      var provider = Provider.of<TransactionProvider>(context,listen: false);
                      provider.addTransaction(statement);
                      Navigator.pop(context);

                    }
                  },
                ),       
              ],
            ),
          ),
        ));
  }
}

