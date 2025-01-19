import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

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
    return data.isEmpty ? SizedBox(height: 150,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(left:20.0,right: 20),
                    child: Shimmer.fromColors(baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!, child: Container(
                      height: 10,margin: const EdgeInsets.only(top: 10),decoration: const BoxDecoration(color: Colors.white),
                    )),
                  );
                }),
            ): Container( height: 150, padding: const EdgeInsets.only(left: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Container(height: 200,width: 200,padding: const EdgeInsets.only(top: 20,left: 5,right: 5),
              child: Stack(children: [
                SizedBox(height: double.infinity,width: double.infinity,
                  child: ClipRRect(borderRadius: BorderRadius.circular(20),child: 
                 Image.asset('assets/images/bg.jpg',fit: BoxFit.fill,))),
                Padding(padding: const EdgeInsets.only(left: 30,right: 10,top: 15),
                  child: Image.network(data[index]['strCategoryThumb'].toString())),
                
                Container(alignment: Alignment.bottomLeft,padding: const EdgeInsets.only(bottom: 6),width: double.infinity,height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(data[index]['strCategory'],style: const TextStyle(fontFamily: 'font1',fontSize: 20,color: Colors.white),),
                  ),
                ),
                ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,shadowColor: Colors.transparent),child: const SizedBox(height: 190,width: 190),),          
              ],),
            );
          },
        ),
      );
  }
}
