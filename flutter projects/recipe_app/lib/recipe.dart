import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/firebase_services.dart';
import 'package:http/http.dart' as http;

import 'package:shimmer/shimmer.dart';

class RecipeCard extends StatefulWidget {
 final String api;
   const RecipeCard({super.key,required this.api});
   
  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool isLoading=true;
   bool isLiked=false;
 
  List<dynamic> data=[];

  Future<void> fetch() async {
    final response =await http.get(Uri.parse(widget.api));
          if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          data = jsonDecode(response.body)['meals'];
        
        
        });
      }
        //  

if(mounted) {
  isLiked= await FirebaseServices().isRecipeLiked(data[0]['idMeal']);
  setState(() {
  isLoading=false;
});
} 


    } else {
     throw Exception('CH');
    }

   
  }
@override
  void initState(){
    
    super.initState();
     fetch();

  }
  @override
  Widget build(BuildContext context) {
    return isLoading?SizedBox(height: 150,
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
            ):
    Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.grey[100]),
          margin: const EdgeInsets.only(left: 15, right: 15),
          padding: const EdgeInsets.all(5),
          height: 110,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  data[0]['strMealThumb'].toString(),
                  width: 110,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[0]['strCategory'].toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'font1',
                          color: Color.fromRGBO(9, 194, 241, 1),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        data[0]['strMeal'].toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'font1',
                          color: Colors.black87,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(CupertinoIcons.tag, size: 20),
                          Expanded(
                            child: Text(
                              (data[0]['strTags'] == null ||
                                      data[0]['strTags'] ==
                                          'null')
                                  ? '  NO TAGS'
                                  : '  ${data[0]['strTags']
                                      .toString()
                                      .split(',')
                                      .join(' ')} ',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black54),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      FirebaseServices().toggleLike(data[0]['idMeal'].toString());
                      isLiked=!isLiked;
                    });
                  },
                  icon: (isLiked)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border_rounded,
                        ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}





class TempRecipeCard extends StatefulWidget {

   const TempRecipeCard({super.key});
   
  @override
  State<TempRecipeCard> createState() => _TempRecipeCardState();
}

class _TempRecipeCardState extends State<TempRecipeCard> {
  bool isLiked=false;
 
@override
  void initState(){
    
    super.initState();
     

  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.grey[100]),
          margin: const EdgeInsets.only(left: 15, right: 15),
          padding: const EdgeInsets.all(5),
          height: 110,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/bg.jpg',
                  width: 110,
                  fit: BoxFit.cover,
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'font1',
                          color: Color.fromRGBO(9, 194, 241, 1),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                       'Name',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'font1',
                          color: Colors.black87,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(CupertinoIcons.tag, size: 20),
                          Text('data')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      
                      isLiked=!isLiked;
                    });
                  },
                  icon: (isLiked)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border_rounded,
                        ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

