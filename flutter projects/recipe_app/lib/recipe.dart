import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:recipe_app/global.dart';

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
                  exploreData[widget.index]['strMealThumb'].toString(),
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
                        exploreData[widget.index]['strCategory'].toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'font1',
                          color: Color.fromRGBO(9, 194, 241, 1),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        exploreData[widget.index]['strMeal'].toString(),
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
                              (exploreData[widget.index]['strTags'] == null ||
                                      exploreData[widget.index]['strTags'] ==
                                          'null')
                                  ? '  NO TAGS'
                                  : '  ${exploreData[widget.index]['strTags']
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
                      liked[int.parse( exploreData[widget.index]['idMeal'].toString())] = !(liked[int.parse( exploreData[widget.index]['idMeal'].toString())] ?? false);
                    });
                  },
                  icon: ((liked[int.parse( exploreData[widget.index]['idMeal'].toString())] ?? false))
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
