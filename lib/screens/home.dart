import 'package:basic_banking_app/screens/users.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(48.0),
              child: Image(
                image: AssetImage(
                  "assets/images/bank.png",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Users()));
                
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 91, 17, 217),
                  padding: const EdgeInsets.all(8),
                  minimumSize: const Size(180, 40)),
              child: Text(
                "View Users",
                style: TextStyle(fontSize: 20, color: Colors.yellow[300]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
