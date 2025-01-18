import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_app/category.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/global.dart';
import 'package:shimmer/shimmer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
bool loading=true;

Future<void> fetch() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));

    if (response.statusCode == 200) {if(mounted) {
      setState(() {
        data = jsonDecode(response.body)['meals'];
       loading=false;
      });
    }
    } else {
      
    }
  }
@override
  void initState() {
   
    super.initState();
    fetch();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      color: Color.fromARGB(203, 205, 218, 255),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Color.fromARGB(203, 205, 218, 255),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_sharp,
                      color: Color.fromARGB(203, 205, 218, 255),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "DISCOVER",
                style: TextStyle(
                  color: Color.fromARGB(255, 24, 42, 72),
                  fontFamily: 'font',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            if(data.isEmpty)SizedBox(height: 250,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context,index){
                  return Padding(
                   padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Shimmer.fromColors(baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!, child: Container(
                      height: 20,margin: const EdgeInsets.only(top: 10),decoration: const BoxDecoration(color: Colors.amber),
                    )),
                  );
                }),
            )
            else
            Container(
              width: double.infinity,
              height: 300,
              padding: const EdgeInsets.all(20),
              
              child: Stack(
                children: [
                  ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.zero, 
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(data[0]['strMealThumb'].toString(),fit: BoxFit.fitWidth)
                      ),
                      
                
                     Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: ElevatedButton(onPressed: () {
                            
                          },style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
                            child: Text( 
                                  data[0]['strMeal'].toString().toUpperCase(),
                                  style:  const TextStyle(backgroundColor: Colors.transparent,textBaseline: TextBaseline.alphabetic,
                                    color: Colors.lightBlueAccent,
                                    fontSize: 18,
                                    fontFamily: 'font1',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          ),
                        ),
                            const SizedBox(height: 130),
                            Row(
                              children: [
                                ElevatedButton(onPressed: () {
                                  
                                },style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ), child: const Text('CHECK RECIPE >>',style: TextStyle(color: Colors.lightBlueAccent,fontSize: 18,fontFamily: 'font1',fontWeight: FontWeight.bold),)),
                                 const Spacer(),
                                 IconButton(onPressed: (){
                                  setState(() {
                                    if(liked[0]==true) {
                                      liked[0]=false;
                                    } else {
                                      liked[0]=true;
                                    }
                                  });
                                 }, icon: (liked[0]==true)?const Icon(Icons.favorite,color: Colors.red,):const Icon(Icons.favorite_border_rounded),style: IconButton.styleFrom(backgroundColor: Colors.transparent),)
                              ],
                            ),
                           
                          ],
                        ),
                      ),
                    ],
                  ),
                )],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('CATEGORIES',style: TextStyle(fontFamily: 'font',fontWeight: FontWeight.bold,fontSize: 25),),
            )
            ,const CategoryChips(),
            const Padding(
              padding: EdgeInsets.only(left: 20,top: 10),
              child: Text(
                "EXPLORE",
                style: TextStyle(
                  color: Color.fromARGB(255, 24, 42, 72),
                  fontFamily: 'font',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
  
          ],
        ),
      );
  }
}