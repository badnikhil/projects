import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50, left: 30),
            child: Row(
              children: [
                const Text(
                  "Instagram",
                  style: TextStyle(fontFamily: 'logo', fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.messenger_outline_sharp),
                  style: IconButton.styleFrom(iconSize: 30),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
         
        ],
      );
  }
}