import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {Key? key, required this.id, required this.name,  this.onTap})
      : super(key: key);
  final int id;
  final String name;
  final  VoidCallback? onTap ;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 83, 170, 115)),
          height: 90,
          child: Row(
            children: [
              Container(
                color: Colors.teal[100],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ID: $id',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      'Name: $name',
                      style:const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
