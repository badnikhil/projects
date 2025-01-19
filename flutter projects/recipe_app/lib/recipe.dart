import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:recipe_app/explore.dart';

class RecipeCard extends StatefulWidget {
 final int index;
  const RecipeCard({super.key,required this.index});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(decoration: BoxDecoration(color: Colors.grey[100]),margin: const EdgeInsets.only(left: 15,right: 15),padding: const EdgeInsets.all(5),height: 110,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  exploreData[widget.index]['strMealThumb'].toString(),width: 130,
                  fit: BoxFit.cover, 
                ),
              ),
              
              
              Expanded( 
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 10),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Text(
                        exploreData[widget.index]['strCategory'].toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'font1',
                          color: Color.fromRGBO(9, 194, 241, 1),
                        ),
                      ),
                      const SizedBox(height: 5),
                      
                      
                      Text(exploreData[widget.index]['strMeal'].toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'font1',
                          color: Colors.black87,
                        ),
                        softWrap: true, 
                        overflow: TextOverflow.ellipsis, 
                        maxLines: 1, 
                      ),
                      
                      const Row(
                        children: [
                          Icon(CupertinoIcons.tag),
                          SizedBox(width: 5),
                          Text('tags'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          
              
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.favorite_border),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
