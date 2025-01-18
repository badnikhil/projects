import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryChips extends StatefulWidget {
  const CategoryChips({super.key});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  List<dynamic> data = [];

  
  Future<void> fetch() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));
    
    if (response.statusCode == 200) {
      if(mounted) {
        setState(() {
        data = jsonDecode(response.body)['categories'];
      });
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container( height: 150, padding: const EdgeInsets.only(left: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),

              child: Container(width: 200,height: 150,decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),

              )
              ,
             
                child: Stack(children: [
                  SizedBox(height: 150,
                    child: ClipRRect(borderRadius: BorderRadius.circular(20),child: 
                   Image.asset('assets/images/bg.jpg',fit: BoxFit.fill,))),
                  Padding(padding: const EdgeInsets.only(left: 30,right: 10,top: 15),
                    child: Image.network(data[index]['strCategoryThumb'].toString())),
                  
                  Container(alignment: Alignment.bottomLeft,padding: const EdgeInsets.only(bottom: 6),width: double.infinity,height: double.infinity,
                    child: ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,alignment: Alignment.bottomLeft
                      ,minimumSize: const Size(double.infinity,double.infinity)
                    ), child: Text(data[index]['strCategory'],style: const TextStyle(fontFamily: 'font1',fontSize: 20,color: Colors.white),),),
                  )

                ],)
              ),
            );
          },
        ),
      );
    }
  }
}
