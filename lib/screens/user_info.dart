import 'package:flutter/material.dart';

import '../sqldb.dart';

class UserInfo extends StatefulWidget {
  UserInfo({super.key, this.id, this.name, this.balance, this.email});

  final dynamic? id;
  final dynamic? name;
  final dynamic? email;
  dynamic? balance;
  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final TextEditingController _amountController = TextEditingController();

  final TextEditingController _customerIdController = TextEditingController();

  SqlDb sqlDb = SqlDb();

  Future<void>? _transferMoney(BuildContext context) async {
    List<Map> customers = await sqlDb.readData("SELECT * FROM Users");

    String text = _customerIdController.text;

    if (_amountController.text.isEmpty ||
        double.parse(_amountController.text) > widget.balance) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "NOT ENOUGH MONEY 😐",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xFFE74646),
        ),
      );
    } else {
      for (var map in customers) {
        if (map.containsKey("id")) {
          if ((map["id"] == int.parse(text))) {
            int tran1 = await sqlDb.updateData('''
  UPDATE Users
  SET balance = balance - ${double.parse(_amountController.text)}
  WHERE id = ${widget.id};
    ''');

            int tran2 = await sqlDb.updateData('''
  UPDATE Users
  SET balance = balance + ${double.parse(_amountController.text)}
  WHERE id = ${int.parse(_customerIdController.text)}; 
    ''');
            setState(() {
              widget.balance -= double.parse(_amountController.text);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "THE OPERATION ACCEPTED SUCCESSFULLY ✅",
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Color.fromARGB(255, 109, 255, 121),
              ),
              
            );
            _amountController.clear();
              _customerIdController.clear();
          }
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    widget.balance;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _customerIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "${widget.name.toString()}'s Info",
            style: TextStyle(
              color: Colors.yellow[300],
              fontSize: 24,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal[300],
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                child: const Image(
                  image: AssetImage(
                    "assets/images/profile_3135715.png",
                  ),
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "ID : ",
                    style: TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.id.toString(),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Divider(
                color: Colors.blue[200],
                height: 30,
                endIndent: 200,
                thickness: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Name : ",
                    style: TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.name.toString(),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Divider(
                color: Colors.blue[200],
                height: 30,
                indent: 200,
                thickness: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Email : ",
                    style: TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.email.toString(),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Divider(
                color: Colors.blue[200],
                height: 30,
                endIndent: 200,
                thickness: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Balance : ",
                    style: TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.balance.toString(),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Divider(
                color: Colors.blue[200],
                height: 40,
                indent: 200,
                thickness: 1.5,
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Transfer Money By ID: ",
                      style: TextStyle(
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: TextField(
                  controller: _customerIdController,
                  decoration: const InputDecoration(
                    labelText: 'Customer ID',
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton.extended(
            onPressed: () {
              _transferMoney(context);
              
            },
            label: const Text('Transfer'),
            icon: const Icon(Icons.verified_outlined),
            backgroundColor: Colors.green,
          ),
        ));
  }
}
