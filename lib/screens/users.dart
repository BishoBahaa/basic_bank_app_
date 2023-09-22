import 'package:basic_banking_app/screens/user_info.dart';
import 'package:basic_banking_app/sqldb.dart';
import 'package:flutter/material.dart';

import '../widgets/item.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  SqlDb sqlDb = SqlDb();

  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM Users");
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Users',
            style: TextStyle(
              color: Colors.yellow[300],
              fontSize: 24,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal[300],
        elevation: 1,
      ),
      body: Container(
        child: ListView(
          children: [
            // MaterialButton(
            //   onPressed: () async {
            //     int response = await sqlDb.insertData(
            //         "INSERT INTO 'Users' (name,email,balance) VALUES('Asher','Asher@email.com',7863.48) ");
            //     print('inserted: $response');
            //   },
            //   child: Text('insert'),
            // ),
            // MaterialButton(
            //   onPressed: () async {
            //     await sqlDb.deleteDb();
            //   },
            //   child: Text('delete'),
            // ),
            FutureBuilder(
                future: readData(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListItem(
                          id: snapshot.data![index]['id'],
                          name: snapshot.data![index]['name'],
                          onTap: () {
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return UserInfo(
                                  id: snapshot.data![index]['id'],
                                  name: snapshot.data![index]['name'],
                                  email: snapshot.data![index]['email'],
                                  balance: snapshot.data![index]['balance'],
                                );
                              }),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
