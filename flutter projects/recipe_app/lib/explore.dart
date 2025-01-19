
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/global.dart';
import 'package:recipe_app/recipe.dart';
import 'package:shimmer/shimmer.dart';



int objects =20;

  class Explore extends StatefulWidget {

  const Explore({super.key});
 

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<bool> exploreLoading=List.generate(objects, (index)=>true);

  Future<void> fetch() async {
   for(int i=0;i<objects;i++){
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          
          
         exploreData.add(jsonDecode(response.body)['meals'][0]);
          exploreLoading[i]=false;
          
          
        });
      }
    } else {
      throw Exception('unhaandled');
    }}
  
 
  }
  @override
  void initState() {
    super.initState();
  
    fetch();

  }

  
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 2620,
      child: ListView.builder(scrollDirection: Axis.vertical,physics: const NeverScrollableScrollPhysics(),
        itemCount:objects,
        
        itemBuilder: (context,index,){
          return  (exploreLoading[index])?SizedBox(height: 150,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(left:20.0,right: 20),
                    child: Shimmer.fromColors(baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!, child: Container(
                      height: 10,margin: const EdgeInsets.only(top: 10),decoration: const BoxDecoration(color: Colors.white),
                    )),
                  );
                }),
            ):Padding(
              padding: const EdgeInsets.only(left: 5,top:  8.0,bottom: 8,right: 5),
              child: RecipeCard(index: index),
            );
      
          
        }),
    );
  }
}