import 'package:flutter/material.dart';

Widget stories(){
   return SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8, 
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage(
                        index == 0 
                          ? 'assets/profile/mypic.png' 
                          : 'assets/profile/profile${index+1}.jpeg' 
                      ),
                    ),
                  ),
                Text('Name')],
                
              );
            },
          ),
        );
}