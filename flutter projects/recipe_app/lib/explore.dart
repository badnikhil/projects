
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/recipe.dart';
import 'package:shimmer/shimmer.dart';

List<dynamic> exploreData=[];
  class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<bool> loading=List.generate(11, (index)=>true);

  Future<void> fetch() async {
   for(int i=0;i<10;i++){
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          
          
         exploreData.add(jsonDecode(response.body)['meals'][0]);
          loading[i]=false;
          
        });
      }
    } else {
      throw Exception('unhaandled');
    }}
  
 
  }
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    fetch();

  }

  
  @override
  Widget build(BuildContext context) {
    return Container(height: 1300,
      child: ListView.separated(scrollDirection: Axis.vertical,physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        separatorBuilder: (context, index) => const SizedBox(height: 20) ,
        itemBuilder: (context,index,){
              
               
          return  (loading[index])?SizedBox(height: 150,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(left:20.0,right: 20),
                    child: Shimmer.fromColors(baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!, child: Container(
                      height: 10,margin: const EdgeInsets.only(top: 10),decoration: const BoxDecoration(color: Colors.white),
                    )),
                  );
                }),
            ):RecipeCard(index: index);
      
          
        }),
    );
  }
}