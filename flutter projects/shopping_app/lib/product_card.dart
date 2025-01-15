import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {final String title;final double price;final String imgurl;
final Color backgroung;
  const ProductCard({super.key,required this.title,required this.price,required this.imgurl,required this.backgroung});

  @override
  Widget build(BuildContext context) {
    return   Container(
    margin:const  EdgeInsets.all(16),padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:backgroung,),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              Text('\$$price',style: Theme.of(context).textTheme.titleLarge,),
               const SizedBox(height: 5),
                   Center(
                    child: Image(
                      image: AssetImage(imgurl),height: 175,),
                  ),
                
            ],
          ),
    );
  } 
}